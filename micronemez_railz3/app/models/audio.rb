class Audio < ActiveRecord::Base
  #acts_as_taggable
  #will alias to :keyword_list
  acts_as_taggable_on :tag, :keyword
	
  belongs_to :user 

  has_one :kaltura_audio
  
  validates :title, :presence => true,
            :length => { :minimum => 3 }
  #validates :location,  :presence => true
  #TODO: pluralize
  #validates :tag_list,  :presence => true
  #TODO: handle failed file upload
  #validates :audio_upload, :attachment_presence => true
   
  #TODO: does :audio_upload need to be here?
  attr_accessible :title, :location, :description, :audio_upload, :tag_list
  
  validates_attachment_size :audio_upload, :less_than => 999.megabytes
  validates_attachment_content_type :audio_upload, :content_type => [ /^audio/, nil ], :message => 'please upload correct format'

  #validates_attachment_extension :audio_upload,
  #  :extensions => %w[jpg jpeg gif png]

    
  has_attached_file :audio_upload, 
    :hash_secret => Micronemez::Application.config.upload_secret_token,
    :storage => :cloud_files,
    #:cloudfiles_credentials =>  "#{RAILS_ROOT}/config/rackspace.yml",
    :path => "/opt/drop/:catnum.:extension"
    #:url => "/u/:hashed_path/:catnum.:extension",
    #:path => ":rails_root/public/u/:hashed_path/:catnum.:extension",
    #:url => ":rails_root/public/u/:hashed_path/:catnum.:extension",
    # does not really matter what is in the :styles hash, just that it does exist...
    #no longer necessary
    #:styles => { :default => { } },
    #:processors => [ :file_upload_job ]

  
  
  before_create :generate_catnum
  #after_save :move_file
  
  #@SuppressWarnings("unused")
  def audio
    [ 'application/x-mp4',
      'audio/mpeg',
      'audio/quicktime',
      'audio/mp3',
      'audio/mp4',
      'audio/mpeg4',
      'audio/mpeg4-generic',
      'audio/ogg',
      'vorbis/ogg'
    ]
  end
  
  private 
  
  def generate_catnum
    self.catnum = SecureRandom.hex(5)
  end
end
