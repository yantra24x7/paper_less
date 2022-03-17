class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :update, :destroy]

  # GET /tenants
  def index
    @tenants = Tenant.all

    render json: @tenants
  end

  # GET /tenants/1
  def show
    render json: @tenant
  end

  # POST /tenants
  def create
    Role.create(role_name: "Yantra_Admin")
    Role.create(role_name: "Admin")
    Role.create(role_name: "Supervisor")
    Role.create(role_name: "Operator")

    user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], phone_no:params[:phone_no] , dup_password: nil, isactive: true, role: "Admin")

    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      render json: @tenant, status: :created, location: @tenant
    else
      render json: @tenant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tenants/1
  def update
    if @tenant.update(tenant_params)
      render json: @tenant
    else
      render json: @tenant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tenants/1
  def destroy
    @tenant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tenant_params
      params.require(:tenant).permit(:tenant_name, :address_line1, :address_line2, :city, :state, :country, :pincode, :color_code, :calculation, :local_ip, :global_ip, :port, :uname, :pass, :img)
    end
end
