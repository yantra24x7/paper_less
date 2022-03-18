class ReportSerializer < ActiveModel::Serializer
  attributes :id, :date, :shift_no, :shift_date, :question, :method_value, :ans_value, :machine_name, :component_name, :remarks, :created_by


end

  # field :date, type: Date, default: Time.now
  # field :shift_date, type: Date
  # field :shift_no, type: String
  # field :question, type: String
  # field :method, type: String
  # field :filter, type: String
  # field :value, type: String
  # field :min, type: String
  # field :max, type: String
  # field :machine_name, type: String
  # field :component_name, type: String
  # field :created_by, type: String