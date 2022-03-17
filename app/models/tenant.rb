class Tenant
  include Mongoid::Document
  include Mongoid::Timestamps
  field :tenant_name, type: String
  field :address_line1, type: String
  field :address_line2, type: String
  field :city, type: String
  field :state, type: String
  field :country, type: String
  field :pincode, type: String
  field :color_code, type: String
  field :calculation, type: String
  field :local_ip, type: String
  field :global_ip, type: String
  field :port, type: String
  field :uname, type: String
  field :pass, type: String
  field :img, type: File
end
