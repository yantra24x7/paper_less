class ComponentItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :item_name, type: String
  field :is_view, type: Mongoid::Boolean
  field :file_execute, type: Mongoid::Boolean, default: false
  field :file_execute_time, type: Date
  field :comp_name, type: String
  field :machie_name, type: String
  field :reg_by, type: String
 # mount_uploader :avatar, AvatarUploader
  field :avatar, type: String
  belongs_to :component
  belongs_to :machine
  has_many :component_item_transactions, dependent: :destroy
  has_many :component_item_questions

  validates_uniqueness_of :component_id, :scope => [:item_name, :comp_name]

  

end
