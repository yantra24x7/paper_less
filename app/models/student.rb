class Student
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :age, type: String
  mount_uploader :avatar, AvatarUploader
end
