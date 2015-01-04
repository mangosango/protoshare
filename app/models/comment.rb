class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :commentable, polymorphic: true
  field :author,	type: String, default: ""
  field :authorname,type: String, default: ""
  field :body,      type: String, default: ""
end
