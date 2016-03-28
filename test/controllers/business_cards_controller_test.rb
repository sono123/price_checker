require 'test_helper'

class BusinessCardsControllerTest < ActionController::TestCase
  setup do
    @print_method = print_methods(:one)
    @ink_color = ink_colors(:one)
    @bleed = bleeds(:one)
    @raised_ink = raised_inks(:one)
    @dimension = dimensions(:one)
    @paper_type = paper_types(:one)
    @coating = coatings(:one)
    @quantity = quantities(:one)
    @box_count = box_counts(:one)
    @metal = metals(:one)
    @business_card = business_cards(:one)
  end

  test "should create business_card" do
    assert_difference('BusinessCard.count') do
      post :create, business_card: { print_method_id: "1", 
                                     ink_color_id: "1", 
                                     bleed_id: "1", 
                                     raised_ink_id: "1", 
                                     dimension_id: "1", 
                                     paper_type_id: "1", 
                                     coating_id: "1", 
                                     quantity_id: "1",
                                     box_count_id: "1",
                                     metal_id: "1",
                                     price: "139",
                                     cost: "49" }
    end

    assert_redirected_to root_path
  end

  test "should get edit" do
    get :edit, id: @business_card
    assert_response :success
  end

  test "should update business_card" do
    patch :update, id: @business_card, business_card: {  }
    assert_redirected_to root_path
  end

  test "should destroy business_card" do
    assert_difference('BusinessCard.count', -1) do
      delete :destroy, id: @business_card
    end

    assert_redirected_to root_path
  end
end
