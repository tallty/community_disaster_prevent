require 'test_helper'

class MessageProcessorsControllerTest < ActionController::TestCase
  setup do
    @message_processor = message_processors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:message_processors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message_processor" do
    assert_difference('MessageProcessor.count') do
      post :create, message_processor: {  }
    end

    assert_redirected_to message_processor_path(assigns(:message_processor))
  end

  test "should show message_processor" do
    get :show, id: @message_processor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message_processor
    assert_response :success
  end

  test "should update message_processor" do
    patch :update, id: @message_processor, message_processor: {  }
    assert_redirected_to message_processor_path(assigns(:message_processor))
  end

  test "should destroy message_processor" do
    assert_difference('MessageProcessor.count', -1) do
      delete :destroy, id: @message_processor
    end

    assert_redirected_to message_processors_path
  end
end
