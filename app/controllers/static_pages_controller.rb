class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:contact]

  # This is the homepage.
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

  # This is almost identical to the homepage. The main difference is that action is only hit when a server side validation fails for adding a new business card. Since the app has good client side validations, this action will rarely ever be hit.
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

  # This is for the contact form, which appears in a couple places on the app.
  def message
    @message = params[:message]
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
