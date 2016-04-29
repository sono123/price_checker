class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:contact]

  def home
		@result = flash[:result]
  	@business_card = BusinessCard.new
  	@print_methods = PrintMethod.all
  	@ink_colors = InkColor.all
  	@bleeds = Bleed.all
  	@raised_inks = RaisedInk.all
  	@dimensions = Dimension.all
  	@paper_types = PaperType.all
  	@coatings = Coating.all
  	@quantities = Quantity.all
    @box_counts = BoxCount.all
    @metals = Metal.all
  end

  def error
    @result = flash[:result]
    @business_card = BusinessCard.new
    @print_methods = PrintMethod.all
    @ink_colors = InkColor.all
    @bleeds = Bleed.all
    @raised_inks = RaisedInk.all
    @dimensions = Dimension.all
    @paper_types = PaperType.all
    @coatings = Coating.all
    @quantities = Quantity.all
    @box_counts = BoxCount.all
    @metals = Metal.all
    render :template => 'static_pages/_new_bc_form'
  end

  def help
  end

  def about
  end

  def contact
  end

  def message
    @message = params[:message]
    puts "*" * 100
    p params
    puts "*" * 100
    puts "*" * 100
    p params[:message].length
    puts "*" * 100
    if params[:message].length > 0
      @user = current_user
      @user.send_contact_email(@message)
      flash[:success] = "Your message has been sent."
      redirect_to root_path
    else
      flash[:error] = "Your message could not be sent."
      render :template => 'static_pages/contact'
    end
  end

end
