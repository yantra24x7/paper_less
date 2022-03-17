module Api
  module V1
class ComponentItemsController < ApplicationController
  require 'csv'
  require 'roo'


  before_action :set_component_item, only: [:show, :update, :destroy]

  # GET /component_items
  def index
    @component_items = ComponentItem.all

    render json: @component_items
  end

  
  def com_ques_list
    data =  ComponentItem.find(params[:id]).component_item_questions
    render json: data
  end

  def select_comp_item
    @comp = ComponentItem.where(component_id: params[:id])
    
    render json: @comp
  end

  # GET /component_items/1
  def show
    render json: @component_item
  end

  # POST /component_items
  def create
    #@component_item = ComponentItem.new(component_item_params)
    s3 = Aws::S3::Resource.new(region: ENV['S3_REGION'], access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    bucket = s3.bucket(ENV['S3_BUCKET'])
    file_name = params[:avatar].original_filename
    obj = bucket.object(file_name)
    @file_path =  params[:avatar].path
    #obj.upload_file(@file_path, acl: 'public-read')
    obj.upload_file(@file_path)#, acl: 'public-read')
    pic_url = obj.public_url
    # obj = bucket.object(file_name)

    @component_item = ComponentItem.new(item_name: params[:item_name], is_view: params[:is_view], file_execute: false, file_execute_time: nil, comp_name: params[:comp_name], machie_name: params[:machie_name], component_id: params[:component_id], machine_id: params[:machine_id], avatar: pic_url)
    cr_user = User.find(@current_user['user_id'])
    @component_item[:reg_by] = cr_user.first_name

    @component_item_trans = ComponentItemTransaction.new(item_name: params[:item_name], is_view: params[:is_view], file_execute: false, file_execute_time: nil, comp_name: params[:comp_name], machie_name: params[:machie_name], component_id: params[:component_id], machine_id: params[:machine_id], avatar: pic_url)
    @component_item_trans[:reg_by] = cr_user.first_name
    if @component_item.save
      @component_item_trans[:component_item_id] = @component_item.id.to_s
      @component_item_trans.save
      render json: @component_item, status: :created#, location: @component_item
    else
      render json: @component_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /component_items/1
  def update
     #@component_item = ComponentItem.new(component_item_params)
    s3 = Aws::S3::Resource.new(region: ENV['S3_REGION'], access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    bucket = s3.bucket(ENV['S3_BUCKET'])
    file_name = params[:avatar].original_filename
    obj = bucket.object(file_name)
    @file_path =  params[:avatar].path
    #obj.upload_file(@file_path, acl: 'public-read')
    obj.upload_file(@file_path)#, acl: 'public-read')
    pic_url = obj.public_url
    # obj = bucket.object(file_name)
    
    cr_user = User.find(@current_user['user_id'])
    if @component_item.update(reg_by: cr_user.first_name, avatar: params[:avatar], file_execute: false, file_execute_time: nil)    
       @component_item_trans = ComponentItemTransaction.new(item_name: params[:item_name], is_view: params[:is_view], file_execute: false, file_execute_time: nil, comp_name: params[:comp_name], machie_name: params[:machie_name], component_id: params[:component_id], machine_id: params[:machine_id], avatar: params[:avatar])
       @component_item_trans[:reg_by] = cr_user.first_name
       @component_item_trans[:component_item_id] = @component_item.id.to_s
       @component_item_trans.save
      render json: @component_item
    else
      render json: @component_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /component_items/1
  def destroy
    @component_item.destroy
  end

  def execute_file
    @component_item = ComponentItem.find(params[:id])
    path = @component_item.avatar#.path
   require 'csv'
   require 'roo'
   workbook = Roo::Spreadsheet.open "#{path}"
   worksheets = workbook.sheets

   worksheets.each do |worksheet|
  puts "Reading: #{worksheet}"
  header = []
  num_rows = 0
  workbook.sheet(worksheet).each_row_streaming do |row|
    row_cells = row.map { |cell| cell.value }
    if num_rows == 0
      header << row_cells.map{|jj| jj}
    else
      k = header.flatten
      v = row_cells
      ques = Hash[k.zip(v)]
      ComponentItemQuestion.create(question: ques, component_item_id: params[:id])
    end
    num_rows += 1
  end
  puts "Read #{num_rows} rows" 
end



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
end
end
