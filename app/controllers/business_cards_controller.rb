class BusinessCardsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def create
    search = BusinessCard.search(params["business_card"])
    @result = search[0]

    if @result
      flash[:error] = "That item is already in the system."
      redirect_to root_path
    else
      @business_card = BusinessCard.new(business_card_params)
      puts "******BUSINESS CARD NEW*********"
      puts params["business_card"]["price"]
      puts params["business_card"]["cost"]

      if @business_card.save
        flash[:success] = "Price successfully added."
        @business_card.update_attribute(:user_id, session[:user_id])
        puts "******BUSINESS CARD SAVED*********"
        redirect_to root_path
      else
        puts "******BUSINESS CARD NOT SAVED*********"
        flash[:error] = "Business card could not be added."
        flash[:alert] = @business_card.errors
        flash[:print_method_id] = params["business_card"]["print_method_id"]
        flash[:ink_color_id] = params["business_card"]["ink_color_id"]
        flash[:bleed_id] = params["business_card"]["bleed_id"]
        flash[:raised_ink_id] = params["business_card"]["raised_ink_id"]
        flash[:dimension_id] = params["business_card"]["dimension_id"]
        flash[:coating_id] = params["business_card"]["coating_id"]
        flash[:quantity_id] = params["business_card"]["quantity_id"]
        flash[:box_count_id] = params["business_card"]["box_count_id"]
        flash[:metal_id] = params["business_card"]["metal_id"]
        flash[:paper_type_id] = params["business_card"]["paper_type_id"]
        flash[:error_redirect] = true
        
        redirect_to error_path
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

    if params[:print_method_id].to_i > 0 && params[:ink_color_id].to_i > 0 && params[:paper_type_id].to_i > 0 && params[:quantity_id].to_i > 0 && params[:box_count_id].to_i > 0
      search = BusinessCard.search(params)
      result = search[0]

      if result
        @price = result.price.to_s
        @cost = result.cost.to_s
        @id = result.id.to_s
        @width = trim(result.dimension.width).to_s + '"'
        @height = trim(result.dimension.height).to_s + '"'
        @paper_thickness = result.paper_type.thickness.to_s
        @paper_name = result.paper_type.name.split.map(&:capitalize).join(' ')
        @paper_color = result.paper_type.color.split.map(&:capitalize).join(' ')
        @ink = ink(result)
        @ink_front = result.ink_color.front.to_s
        @ink_back = result.ink_color.back.to_s
        @finishing = finishing(result)
        @print_method = result.print_method.print_method.split.map(&:capitalize).join(' ')
        @quantity = result.quantity.quantity.to_s
        @box_count = result.box_count.box_count.to_s
        @box_price = number_to_currency(result.price.to_f / result.box_count.box_count).to_s
        @turnaround = turnaround_time(result.print_method.print_method.downcase)

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

    else
      render :template => 'static_pages/select_error'
    end

  end

  def more
    similar = BusinessCard.similar_products(params) #[[22, 30], [10, 25], [7, 25], [25, 25], [21, 25], [12, 25], [9, 20], [23, 20], [11, 18], [24, 18], [6, 18]]
    index = params[:index].to_i - 1                 #9
    if similar
      similar_indexes = similar.map {|obj| obj[0]}  #[22, 10, 7, 25, 21, 12, 9, 23, 11, 24, 6]
      similar_indexes.slice!(0..index)              #[6]
      @load_more = similar_indexes[0..4].to_s       #[6]
      @count = similar_indexes.count                #1
      # debugger
    end
    
    render :template => 'static_pages/load_more'
  end

  def destroy
    BusinessCard.find(params[:id]).destroy
    flash[:success] = "Business Card Deleted"
    redirect_to root_path
  end

  private

    def turnaround_time(print_method)
      case print_method
      when "pantone offset"
        "2-3 Business Days"
      when "cmyk offset"
        "3-4 Business Days"
      when "letterpress"
        "2-3 Weeks"
      when "digital"
        "24-48 Hours"
      else
        "2-3 Business Days"
      end
    end

    def ink(result)
      ink_text = ""
      front = result.ink_color.front.to_s
      back = result.ink_color.back.to_s
      print_method = multi_capitalize(result.print_method.print_method)

      ink_text << "#{front}/#{back} #{print_method}"
      ink_text << ", Raised Ink" if result.has_raised_ink?
      ink_text << ", Full Bleed" if result.has_bleed?

      ink_text
    end

    def trim(num)
      int = num.to_i
      flot = num
      int == flot ? int : flot
    end

    def multi_capitalize(string)
      caps = string.split.map(&:capitalize).join(' ').sub("Cmyk", "CMYK").gsub("Uv", "UV")
    end

    def finishing(result) #need boolean instance methods for has_coating?, has_metal?, has_raised_ink?
      finish_text = ""
      if result.has_coating? || result.has_metal?
        finish_text << "#{result.has_coating?}, " if result.has_coating?
        finish_text << "#{multi_capitalize(result.has_metal?)}, " if result.has_metal?
        finish_text.chomp!(', ')
        finish_text
      else
        "None"
      end
    end

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








