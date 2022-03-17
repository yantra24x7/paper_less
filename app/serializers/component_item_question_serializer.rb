class ComponentItemQuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :date
  has_one :component_item
end
