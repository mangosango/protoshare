class Attachment
  include Mongoid::Document
  include Mongoid::Token
  belongs_to :prototype
  belongs_to :user
  # Upload
  # attr_accessible :file, :file_cache
  field :path,    type: String, default: ""
  field :original_filename,    type: String, default: ""
  mount_uploader :file, PrototypeFileUploader  
  token
end