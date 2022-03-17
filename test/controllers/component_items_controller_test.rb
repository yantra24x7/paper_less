require 'test_helper'

class ComponentItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @component_item = component_items(:one)
  end

  test "should get index" do
    get component_items_url, as: :json
    assert_response :success
  end

  test "should create component_item" do
    assert_difference('ComponentItem.count') do
      post component_items_url, params: { component_item: { comp_name: @component_item.comp_name, component_id: @component_item.component_id, file_execute: @component_item.file_execute, file_execute_time: @component_item.file_execute_time, is_view: @component_item.is_view, item_name: @component_item.item_name, machie_name: @component_item.machie_name, machine_id: @component_item.machine_id } }, as: :json
    end

    assert_response 201
  end

  test "should show component_item" do
    get component_item_url(@component_item), as: :json
    assert_response :success
  end

  test "should update component_item" do
    patch component_item_url(@component_item), params: { component_item: { comp_name: @component_item.comp_name, component_id: @component_item.component_id, file_execute: @component_item.file_execute, file_execute_time: @component_item.file_execute_time, is_view: @component_item.is_view, item_name: @component_item.item_name, machie_name: @component_item.machie_name, machine_id: @component_item.machine_id } }, as: :json
    assert_response 200
  end

  test "should destroy component_item" do
    assert_difference('ComponentItem.count', -1) do
      delete component_item_url(@component_item), as: :json
    end

    assert_response 204
  end
end
