class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :password, type:  BCrypt::Password
  field :phone_no, type: String
  field :dup_password, type: String
  field :isactive, type: Mongoid::Boolean, default: true
  field :date, type: Date, default: Time.now
  field :role, type: String
  field :module, type: Array

  #before_create :encrypt_password
  #has_secure_password

  def self.authenticate(email, password)
     user = User.find_by(email: email)
     if user && BCrypt::Password.new(user.password) == password
       user
     else
       nil
     end
  end

  def encrypt_password
    if self.password.present?
      #self.password_hash = BCrypt::Engine.hash_secret(password)
      self.password = BCrypt::Password.create(password)
    end
  end

end
