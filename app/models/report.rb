class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date, default: Time.now
  field :shift_date, type: Date
  field :shift_no, type: Integer
  field :question, type: String
  field :method, type: String
  field :filter, type: String
  field :value, type: String
  field :min, type: String
  field :max, type: String
  field :machine_name, type: String
  field :component_name, type: String
#  belongs_to :component_item
#  belongs_to :machine
end
