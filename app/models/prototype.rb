class Prototype
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Likeable
  include Mongoid::Taggable
  include Mongoid::Token
  include PublicActivity::Common

  # File Uploader
  # embeds_many :files, as: :fileable
  # accepts_nested_attributes_for :files, :allow_destroy => true

  # Title
  field :title,    	   type: String, default: ""
  validates_presence_of :title

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
  has_one :preview, dependent: :destroy
  accepts_nested_attributes_for :preview

  belongs_to :user
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments

  # Comments
  has_many :comments, as: :commentable, dependent: :destroy  

  # Validations
  validates_presence_of :preview
  validates_presence_of :attachments

  token
end