module Api
  module V1
class ComponentItemQuestionsController < ApplicationController
  before_action :set_component_item_question, only: [:show, :update, :destroy]

  # GET /component_item_questions
  def index
    @component_item_questions = ComponentItemQuestion.all

    render json: @component_item_questions
  end

  # GET /component_item_questions/1
  def show
    render json: @component_item_question
  end

  # POST /component_item_questions
  def create
    @component_item_question = ComponentItemQuestion.new(component_item_question_params)

    if @component_item_question.save
      render json: @component_item_question, status: :created#s, location: @component_item_question
    else
      render json: @component_item_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /component_item_questions/1
  def update
    if @component_item_question.update(component_item_question_params)
      render json: @component_item_question
    else
      render json: @component_item_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /component_item_questions/1
  def destroy
    @component_item_question.destroy
    render json: true
  end


  #def upload_component_questions
  #  byebug
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component_item_question
      @component_item_question = ComponentItemQuestion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def component_item_question_params
      params.require(:component_item_question).permit!#(:question, :date, :component_item_id)
    end

    # def com_upload_ques_params
    #   params.require(:component_item_question).permit!
    # end
end
end
end
