class Preview
  include Mongoid::Document
  include Mongoid::Token
  belongs_to :prototype
  belongs_to :user
  # Upload
  # attr_accessible :file, :file_cache
  mount_uploader :image, PreviewUploader
  token
end