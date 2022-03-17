class Component
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :comp_number, type: String
  field :machine_name, type: String
  field :isactive, type: Mongoid::Boolean, default: true
  field :reg_by, type: String
  field :date, type: Date, default: Time.now
  #mount_uploader :avatar, AvatarUploader
  belongs_to :machine
  belongs_to :user

  #validates_uniqueness_of :name, :comp_number scope: [:machine_id]
  #validates_uniqueness_of :name, :scope => :machine_id

  validates_uniqueness_of :machine_id, :scope => [:name, :comp_number]




end
