class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => Hash
  field :filter, :type => String
end
