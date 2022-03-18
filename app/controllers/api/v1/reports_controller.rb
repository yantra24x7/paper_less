module Api
  module V1
class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :destroy]

  # GET /reports
  def index
    @reports = Report.all

    render json: @reports
  end

  def view_report
      st_time = params[:from_date].present? ? params[:from_date].split('-')[0] : (Date.today - 1).strftime('%m/%d/%Y')
      en_time =   params[:from_date].present? ? params[:from_date].split('-')[1] : (Date.today - 1).strftime('%m/%d/%Y')

      start_time = Date.strptime(st_time, '%m/%d/%Y')
      end_time = Date.strptime(en_time, '%m/%d/%Y')

      range = start_time.to_time..end_time.to_time

    #  if params[:machine_name] == "all"
      machines = params[:machine_name] == "all" ? Machines.pluck(:machine_name) : [params[:machine_name]]
      shifts = params[:shift_num] == "all" ? Shift.pluck(:shift_no) : [params[:shift_num].to_i]
    #  else
      @result = Report.where(date:range, :shift_no.in =>shifts, :machine_name.in => machines)

      # mac_list = L0Setting.pluck(:L0Name, :L0EnName)
      # mac_lists = mac_list.map{|i| [i[0], i[1].split('-').first]}.group_by{|yy| yy[1]}
      # if mac_lists[params[:module]].present?
      #  machines = params[:machine_name] == "all"  ?  mac_lists[params[:module]].map{|i| i[0]} : [params[:machine_name]]
      # else
      #  machines = []
      # end
     
    #  end
      

      #if params[:select_type] == "Operatorwise" && params[:operator_id].present?
      #  results = Report.where(date:range, :shift_num.in =>shifts, :machine_name.in => machines)
      #  res_id = results.select{|i| i.operator_id.include?(params[:operator_id].to_i)}.pluck(:id)

      #  result = Report.where(:id.in=> res_id)
      #else
      #result = Report.where(date:range, :shift_num.in =>shifts, :machine_name.in => machines)
      #end
      render json: @result

  end
  

  # GET /reports/1
  def show
    render json: @report
  end

  # POST /reports
  def create
    shift = Shift.current_shift
    date = Time.now

 case
    when shift.start_day == '1' && shift.end_day == '1'
      shift_date = Date.today
    when shift.start_day == '1' && shift.end_day == '2'
      if Time.now.strftime("%p") == "PM"
        shift_date = Date.today
      else
        shift_date = Date.today - 1.day
      end
    else
      shift_date = Date.tomorrow
    end
    cr_user = User.find(@current_user['user_id'])
    @report = Report.new(report_params)
    @report[:shift_no] = shift.shift_no
    @report[:date] = date
    @report[:shift_date] = shift_date
    @report[:created_by] = cr_user.first_name
    if @report.save
      render json: @report, status: :created#, location: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def report_params
      params.require(:report).permit(:question, :method_value, :filter, :ans_value, :min, :max, :machine_name, :component_name, :date, :shift_no, :remarks)
    end
end
end
end

