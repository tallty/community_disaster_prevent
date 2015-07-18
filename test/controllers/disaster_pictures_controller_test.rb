require 'test_helper'

class DisasterPicturesControllerTest < ActionController::TestCase
  setup do
    @disaster_picture = disaster_pictures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:disaster_pictures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create disaster_picture" do
    assert_difference('DisasterPicture.count') do
      post :create, disaster_picture: {  }
    end

    assert_redirected_to disaster_picture_path(assigns(:disaster_picture))
  end

  test "should show disaster_picture" do
    get :show, id: @disaster_picture
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @disaster_picture
    assert_response :success
  end

  test "should update disaster_picture" do
    patch :update, id: @disaster_picture, disaster_picture: {  }
    assert_redirected_to disaster_picture_path(assigns(:disaster_picture))
  end

  test "should destroy disaster_picture" do
    assert_difference('DisasterPicture.count', -1) do
      delete :destroy, id: @disaster_picture
    end

    assert_redirected_to disaster_pictures_path
  end
end
