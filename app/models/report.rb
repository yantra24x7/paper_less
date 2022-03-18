class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date, default: Time.now
  field :shift_date, type: Date
  field :shift_no, type: String
  field :question, type: String
  field :method, type: String
  field :filter, type: String
  field :method_value, type: String
  field :ans_value, type: String
  field :remarks, type: String
  field :min, type: String
  field :max, type: String
  field :machine_name, type: String
  field :component_name, type: String
  field :created_by, type: String
#  belongs_to :component_item
#  belongs_to :machine
end
