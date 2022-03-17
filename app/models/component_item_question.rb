class ComponentItemQuestion
  include Mongoid::Document
  include Mongoid::Timestamps
  field :question, :type => Array
  field :date, type: Date, default: Time.now
  belongs_to :component_item
end
