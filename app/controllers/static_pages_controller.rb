class StaticPagesController < ApplicationController

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
    redirect_to root_path
  end

end
