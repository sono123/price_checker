require 'test_helper'

class MetalsControllerTest < ActionController::TestCase
  setup do
    @metal = metals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metal" do
    assert_difference('Metal.count') do
      post :create, metal: { back: @metal.back, front: @metal.front }
    end

    assert_redirected_to metals_path
  end

  test "should show metal" do
    get :show, id: @metal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metal
    assert_response :success
  end

  test "should update metal" do
    patch :update, id: @metal, metal: { back: @metal.back, front: @metal.front }
    assert_redirected_to metals_path
  end

  test "should destroy metal" do
    assert_difference('Metal.count', -1) do
      delete :destroy, id: @metal
    end

    assert_redirected_to metals_path
  end
end
