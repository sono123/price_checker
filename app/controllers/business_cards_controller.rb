class BusinessCardsController < ApplicationController

  def create
    search = BusinessCard.search(params["business_card"])
    @result = search[0]

    if @result
      flash[:error] = "That item is already in the system."
      redirect_to root_path
    else
      @business_card = BusinessCard.new(business_card_params)
      if @business_card.save
        flash[:success] = "Price successfully added."
        redirect_to root_path
      else
        flash[:error] = "Business card could not be added."
        flash[:alert] = @business_card.errors
        # @business_card.errors.each do |type, message|
        #   flash[type] = "Check #{type}!"
        # end
        redirect_to root_path
      end
    end
  end

  def edit
    @business_card = BusinessCard.find(params[:id])
  end

  def update
    @business_card = BusinessCard.find(params[:id])
    @business_card.update_attributes("price" => params[:business_card][:price], "cost" => params[:business_card][:cost])
    flash[:success] = "Price successfully updated."
    redirect_to root_path
  end

  def search
    search = BusinessCard.search(params)
    result = search[0]

    if result
      @price = result.price.to_s
      @cost = result.cost.to_s
      @id = result.id.to_s
      render :template => 'static_pages/search'
    else
      similar = BusinessCard.similar_products(params)

      if similar
        @similar = similar.map {|obj| obj[0]}[0..4].to_s
        @count = similar.count
      else
        @count = 0
      end

      render :template => 'static_pages/new_bc'
    end
  end

  def more
    similar = BusinessCard.similar_products(params)
    index = params[:index].to_i - 1

    if similar
      similar_indexes = similar.map {|obj| obj[0]}
      similar_indexes.slice!(0..index)
      @load_more = similar_indexes[0..4].to_s
      @count = similar_indexes.count
    end

    render :template => 'static_pages/load_more'
  end

  def destroy
    BusinessCard.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to root_path
  end

  private

    def business_card_params
      params.require(:business_card).permit(:print_method_id, 
                                            :ink_color_id, 
                                            :bleed_id, 
                                            :raised_ink_id, 
                                            :dimension_id, 
                                            :paper_type_id, 
                                            :coating_id, 
                                            :quantity_id,
                                            :box_count_id,
                                            :metal_id,
                                            :price,
                                            :cost )
    end
end








