module Api
  module V1
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request, only: %i[register login]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    pwd = BCrypt::Password.create(params[:password])
    @user[:password] = pwd
    if @user.save
      render json: @user#, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    pwd = BCrypt::Password.create(params[:password])
    if @user.update(user_params)
      @user.update(password: pwd)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: true
  end

  def register
    if Tenant.count == 0
      Role.create(role_name: "Yantra_Admin")
      Role.create(role_name: "Admin")
      Role.create(role_name: "Supervisor")
      Role.create(role_name: "Operator")
      pwd = BCrypt::Password.create(params[:password])
      user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: pwd, phone_no:params[:phone_no] , dup_password: nil, isactive: true, role: "Admin")
     if user.email == params[:email]
      Tenant.create(tenant_name: params[:tenant_name], address_line1: params[:address_line1], address_line2: params[:address_line2], city: params[:city], state: params[:state], country: params[:country], pincode: params[:pincode], color_code: params[:color_code])
      status = true
     else
      status = false
     end
     render json: status
   else
   render json: false
   end

  end

  def login
    authenticate params[:email], params[:password]
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_no, :dup_password, :isactive, :date, :role, :module)
    end

    def authenticate(email, password)
      command = AuthenticateUser.call(email, password)
      if command.success?
        user_id = JsonWebToken.decode(command.result)["user_id"]
        user = User.find(user_id)
        roles = Role.pluck(:role_name)
        tenant = Tenant.first
        if roles.include?(user.role) && tenant.present?
        render json: {
          access_token: command.result,
          role: user.role,
          module: user.module,
          tenant: tenant.tenant_name,
          clr_code: tenant.color_code,
          message: 'Login Successful'
        }
      else
       render json: false
      end
      else
        render json: false#{ error: command.errors }, status: :unauthorized
      end
    end

end
end
end