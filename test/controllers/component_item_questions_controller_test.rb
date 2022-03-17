require 'test_helper'

class ComponentItemQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @component_item_question = component_item_questions(:one)
  end

  test "should get index" do
    get component_item_questions_url, as: :json
    assert_response :success
  end

  test "should create component_item_question" do
    assert_difference('ComponentItemQuestion.count') do
      post component_item_questions_url, params: { component_item_question: { component_item_id: @component_item_question.component_item_id, date: @component_item_question.date, question: @component_item_question.question } }, as: :json
    end

    assert_response 201
  end

  test "should show component_item_question" do
    get component_item_question_url(@component_item_question), as: :json
    assert_response :success
  end

  test "should update component_item_question" do
    patch component_item_question_url(@component_item_question), params: { component_item_question: { component_item_id: @component_item_question.component_item_id, date: @component_item_question.date, question: @component_item_question.question } }, as: :json
    assert_response 200
  end

  test "should destroy component_item_question" do
    assert_difference('ComponentItemQuestion.count', -1) do
      delete component_item_question_url(@component_item_question), as: :json
    end

    assert_response 204
  end
end
