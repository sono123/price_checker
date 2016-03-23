require 'test_helper'

class BoxCountsControllerTest < ActionController::TestCase
  setup do
    @box_count = box_counts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:box_counts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create box_count" do
    assert_difference('BoxCount.count') do
      post :create, box_count: { box_count: @box_count.box_count }
    end

    assert_redirected_to box_count_path(assigns(:box_count))
  end

  test "should show box_count" do
    get :show, id: @box_count
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @box_count
    assert_response :success
  end

  test "should update box_count" do
    patch :update, id: @box_count, box_count: { box_count: @box_count.box_count }
    assert_redirected_to box_count_path(assigns(:box_count))
  end

  test "should destroy box_count" do
    assert_difference('BoxCount.count', -1) do
      delete :destroy, id: @box_count
    end

    assert_redirected_to box_counts_path
  end
end
