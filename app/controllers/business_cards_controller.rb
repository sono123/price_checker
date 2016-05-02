class BusinessCardsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def create
    # First use the #search class method to see if the business card exists.
    search = BusinessCard.search(params["business_card"])
    # Store the result of the search.
    @result = search[0]

    # If the business card is already in the db, redirect to the main form.
    if @result
      flash[:error] = "That item is already in the system."
      redirect_to root_path
    else
      # Create a new business card.
      @business_card = BusinessCard.new(business_card_params)

      # If the save is successful, add the user who submitted it, then redirect to main form.
      if @business_card.save
        flash[:success] = "Price successfully added."
        @business_card.update_attribute(:user_id, session[:user_id])
        redirect_to root_path
      else
        # If the save is not successful, store the params data and redirect to static_pages#error. That brings the user back to the form, complete with all of the information that they entered. An error message will also appear.
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

  # This action searches the db for the business card that the user submitted.
  def search
    # If the minimum required params data is submitted, the BusinessCard#search class method will be executed.
    if params[:print_method_id].to_i > 0 && params[:ink_color_id].to_i > 0 && params[:paper_type_id].to_i > 0 && params[:quantity_id].to_i > 0 && params[:box_count_id].to_i > 0
      search = BusinessCard.search(params)
      result = search[0]

      # If a result exists, the specifications of the business card are stored to instance variables, then rendered in the view by executing javascript code to insert the data onto the existing page without any browser refresh.
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
        # If the business card does not exist in the db, the BusinessCard#similar_products class method is executed. The result of #similar_products is a nested array [[2, 20], [1, 18]]. Each nested array represents a business card's id and special score that dictates how similar it is to the target business card (the one submitted by the user).
        similar = BusinessCard.similar_products(params)
  
        if similar
        # If similar product[s] exist, they are mapped to return an array of ids only. That array is converted to a string so it can be used with javascript.
          @similar = similar.map {|obj| obj[0]}[0..4].to_s
          # The variable @count is a tally of all similar products which is stored for use in the view, specifically with javascript DOM manipulation.
          @count = similar.count
        else
          # If no similar products exist, count is set to 0, which ensures that nothing is displayed to the user.
          @count = 0
        end
        # After the conditional is executed, the new_bc.js.erb template is executed. This reveals the form for adding the price and cost.
        render :template => 'static_pages/new_bc'
      end

    else
      # This is the else branch of the very first conditional statement. This executes the select error javascript file that simply adds an error message. Note, this branch is unlikely to be reached because of client side validations that exist on the main form.
      render :template => 'static_pages/select_error'
    end

  end

  # The #more controller action is designed to be used as an AJAX call to load more similar products. Since the results are displayed in increments of 5, clicking on the "more" button will load the next 5 similar products.
  def more
    similar = BusinessCard.similar_products(params) 
    # Once again, similar is the entire nested array of id's and scores. A larger example is listed below.
    # [[22, 30], [10, 25], [7, 25], [25, 25], [21, 25], [12, 25], [9, 20], [23, 20], [11, 18], [24, 18], [6, 18]]

    index = params[:index].to_i - 1
    # The value from params[:index] is from one of the form fields (not visible to the user), which is sourced from the data-id from the last similar product within the html. That tells the app where to start from when displaying more similar products. The reason it is called index is because the index is where the app will start from on the nested array.
    if similar
      similar_indexes = similar.map {|obj| obj[0]}
      # The variable similar_indexes maps all of the business cards id's to an array as shown below.
      # [22, 10, 7, 25, 21, 12, 9, 23, 11, 24, 6]

      similar_indexes.slice!(0..index)
      # The code below removes the first nth business card id's from the array.

      @load_more = similar_indexes[0..4].to_s
      # @load_more takes the first 5 id's from the remaining array elements. It also converts them to a string for use in a js.erb file, which then inserts them into the view.

      @count = similar_indexes.count
      # The variable @count is a tally of all similar products which is stored for use in the view, specifically with javascript DOM manipulation.
    end
    
    render :template => 'static_pages/load_more'
    # Finally load_more.js.erb is executed, which contains the javascript code that inserts the next 5 similar products into the page that the user is viewing.
  end

  def destroy
    BusinessCard.find(params[:id]).destroy
    flash[:success] = "Business Card Deleted"
    redirect_to root_path
  end

  private

    # Returns the appropriate turnaround time for the #search action.
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

    # Helps format the ink data for a business card for the #search action.
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

    # Removes the decimal point and zero for whole numbers.
    def trim(num)
      int = num.to_i
      flot = num
      int == flot ? int : flot
    end

    # Capitalizes strings that have multiple words. Also capitalizes certain abbreviations.
    def multi_capitalize(string)
      caps = string.split.map(&:capitalize).join(' ').sub("Cmyk", "CMYK").gsub("Uv", "UV")
    end

    # Returns a concatinated string of finishes.
    def finishing(result)
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

    # Strong params.
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








