class Attachment
  include Mongoid::Document
  belongs_to :prototype
  # Upload
  # attr_accessible :file, :file_cache
  field :path,    type: String, default: ""
  mount_uploader :file, PrototypeFileUploader
end