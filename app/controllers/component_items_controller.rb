class ComponentItemsController < ApplicationController
  before_action :set_component_item, only: [:show, :update, :destroy]

  # GET /component_items
  def index
    @component_items = ComponentItem.all

    render json: @component_items
  end

  def com_ques_list
    byebug
    
  end


  # GET /component_items/1
  def show
    render json: @component_item
  end

  # POST /component_items
  def create
    @component_item = ComponentItem.new(component_item_params)

    if @component_item.save
      render json: @component_item, status: :created, location: @component_item
    else
      render json: @component_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /component_items/1
  def update
    if @component_item.update(component_item_params)
      render json: @component_item
    else
      render json: @component_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /component_items/1
  def destroy
    @component_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component_item
      @component_item = ComponentItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def component_item_params
      params.require(:component_item).permit(:item_name, :is_view, :file_execute, :file_execute_time, :comp_name, :machie_name, :component_id, :machine_id)
    end
end
