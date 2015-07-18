require 'test_helper'

class DisasterPositionsControllerTest < ActionController::TestCase
  setup do
    @disaster_position = disaster_positions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:disaster_positions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create disaster_position" do
    assert_difference('DisasterPosition.count') do
      post :create, disaster_position: {  }
    end

    assert_redirected_to disaster_position_path(assigns(:disaster_position))
  end

  test "should show disaster_position" do
    get :show, id: @disaster_position
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @disaster_position
    assert_response :success
  end

  test "should update disaster_position" do
    patch :update, id: @disaster_position, disaster_position: {  }
    assert_redirected_to disaster_position_path(assigns(:disaster_position))
  end

  test "should destroy disaster_position" do
    assert_difference('DisasterPosition.count', -1) do
      delete :destroy, id: @disaster_position
    end

    assert_redirected_to disaster_positions_path
  end
end
