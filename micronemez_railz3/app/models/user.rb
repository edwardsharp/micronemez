class User < ActiveRecord::Base
  # default devise modules. others available are:
  # :token_authenticatable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
  devise :encryptable, :encryptor => :sha512
  devise :omniauthable

  validates :email, :presence => true, 
            :length => {:minimum => 3, :maximum => 254},
            :uniqueness => true,
            :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :username, :presence => true
  validates :agree, :presence => true
  
  acts_as_tagger
  
  # setup accessible (or protected) model attributes (and now with omniauth providerz!)
  attr_accessible :provider, :uid, :email, :password, :password_confirmation, :remember_me, :agree, :username, :name, :zip

  has_and_belongs_to_many :roles
  has_many :videos, :dependent => :nullify
  has_many :nodes, :dependent => :nullify 
  has_many :audios, :dependent => :nullify
  has_many :schedules, :dependent => :nullify
  has_many :topics, :dependent => :nullify
  has_many :posts, :dependent => :nullify

  #for _header view
  OMNIAUTH_PROVIDERS = ['facebook', 'twitter']
  #OMNIAUTH_PROVIDERS = []
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def make_admin
    begin
      Rails.logger.info("- - - - MAKING A NEW ADMIN!") 
      self.roles << Role.admin
    rescue ActiveRecord::AssociationTypeMismatch
      p "ensure that you have created this role type! e.g. rake micronemez:admin:create_role[admin,user]"
    end
  end

  def revoke_admin
    self.roles.delete(Role.admin)
  end

  def admin?
    role?(:admin)
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        Rails.logger.info("session__devise_fb_data: #{data.inspect}")
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
