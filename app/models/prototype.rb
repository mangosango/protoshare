class Prototype
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Likeable
  include Mongoid::Commentable
  include Mongoid::Taggable

  # URLs
  field :index_url,    type: String, default: ""
  field :code_url,     type: String, default: ""
  field :preview_url,  type: String, default: ""
  field :short_url,    type: String, default: ""

  # Meta Info
  field :device,       type: String, default: ""
  field :description,  type: String, default: ""

  # File Uploader
  mount_uploader :folder, PrototypeFileUploader

end