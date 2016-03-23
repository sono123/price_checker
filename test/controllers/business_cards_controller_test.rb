require 'test_helper'

class BusinessCardsControllerTest < ActionController::TestCase
  setup do
    @business_card = business_cards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_cards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_card" do
    assert_difference('BusinessCard.count') do
      post :create, business_card: {  }
    end

    assert_redirected_to business_card_path(assigns(:business_card))
  end

  test "should show business_card" do
    get :show, id: @business_card
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business_card
    assert_response :success
  end

  test "should update business_card" do
    patch :update, id: @business_card, business_card: {  }
    assert_redirected_to business_card_path(assigns(:business_card))
  end

  test "should destroy business_card" do
    assert_difference('BusinessCard.count', -1) do
      delete :destroy, id: @business_card
    end

    assert_redirected_to business_cards_path
  end
end
