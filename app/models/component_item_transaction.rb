class ComponentItemTransaction
  include Mongoid::Document
  include Mongoid::Timestamps
  field :item_name, type: String
  field :is_view, type: Mongoid::Boolean
  field :file_execute, type: Mongoid::Boolean, default: false
  field :file_execute_time, type: Date
  field :comp_name, type: String
  field :machie_name, type: String
  mount_uploader :avatar, AvatarUploader
  belongs_to :component
  belongs_to :component_item
  belongs_to :machine
end
