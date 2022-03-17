class Machine
  include Mongoid::Document
  include Mongoid::Timestamps
  field :machine_name, type: String
  field :line, type: String#, default: -> { self.MA.split('-').first}
  has_many :components, dependent: :destroy

  validates :machine_name, uniqueness: true
  
end
