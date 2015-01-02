class Prototype
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Likeable
  include Mongoid::Commentable
  include Mongoid::Taggable

  # File Uploader
  # embeds_many :files, as: :fileable
  # accepts_nested_attributes_for :files, :allow_destroy => true

  # Title
  field :title,    	   type: String, default: ""

  # URLs
  field :index_url,    type: String, default: ""
  field :code_url,     type: String, default: ""
  field :preview_url,  type: String, default: ""
  field :short_url,    type: String, default: ""

  # Meta Info
  field :device,       type: String, default: ""
  field :description,  type: String, default: ""

  # field :attachments,  :type => Hash

  # Upload
  # mount_uploaders :attachments, PrototypeFileUploader
  belongs_to :user
  has_many :attachments, dependent: :delete
  accepts_nested_attributes_for :attachments

  validates_presence_of :title
end