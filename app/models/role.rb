class Role
  include Mongoid::Document
  include Mongoid::Timestamps
  field :role_name, type: String
  validates :role_name, uniqueness: true
end
