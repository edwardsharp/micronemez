class Node < ActiveRecord::Base

	acts_as_taggable_on :tag, :keyword

	belongs_to :user

	validates :name, :presence => true,
            :length => { :minimum => 3 }

	attr_accessible :name, :description, :catnum, :location, :date, :tag_list, :is_public, :thumbnail_url, :file_saveto, :file_pub_url, :file_cdn_url, :asset_upload, :asset_upload_file_name

  #validates_attachment_size :asset_upload, :less_than => 999.megabytes
  validates_attachment_content_type :asset_upload, :content_type => [ /^video/, nil ], :message => 'please upload correct format (only videoz, atm.)'

  #validates_attachment_extension :asset_upload,
  #  :extensions => %w[jpg jpeg gif png]

  has_attached_file :asset_upload, 
    :hash_secret => Micronemez::Application.config.upload_secret_token,
    :storage => :cloud_files,
    :cloudfiles_credentials => Micronemez::Application.config.cloudfilez,
    :path => ":catnum.:extension"
    #:url => "/u/:hashed_path/:catnum.:extension",
    #:path => ":rails_root/public/u/:hashed_path/:catnum.:extension",
    #:url => ":rails_root/public/u/:hashed_path/:catnum.:extension",
    # does not really matter what is in the :styles hash, just that it does exist...
    #no longer necessary
    #:styles => { :default => { } },
    #:processors => [ :file_upload_job ]

  
  
  before_create :generate_catnum
  #after_save :move_file
  scope :onlypublic, lambda {
    #yeah, :public is a bool!
    where :is_public => true
  }

  default_scope order 'created_at DESC'

  #@SuppressWarnings("unused")
  def video
    [ 'application/x-mp4',
      'video/mpeg',
      'video/quicktime',
      'video/x-la-asf',
      'video/x-ms-asf',
      'video/x-msvideo',
      'video/x-sgi-movie',
      'video/x-flv',
      'flv-application/octet-stream',
      'video/3gpp',
      'video/3gpp2',
      'video/3gpp-tt',
      'video/BMPEG',
      'video/BT656',
      'video/CelB',
      'video/DV',
      'video/H261',
      'video/H263',
      'video/H263-1998',
      'video/H263-2000',
      'video/H264',
      'video/JPEG',
      'video/MJ2',
      'video/MP1S',
      'video/MP2P',
      'video/MP2T',
      'video/mp4',
      'video/MP4V-ES',
      'video/MPV',
      'video/mpeg4',
      'video/mpeg4-generic',
      'video/nv',
      'video/parityfec',
      'video/pointer',
      'video/raw',
      'video/rtx' ]
  end
  
  private 
  
  def generate_catnum
    self.catnum = SecureRandom.hex(5)
  end

end
