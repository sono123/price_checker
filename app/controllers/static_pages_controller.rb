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
    # @result = flash[:result]
    # @business_card = BusinessCard.new
    # @print_method = PrintMethod.find(flash[:print_method_id])
    # @ink_color = InkColor.find(flash[:ink_color_id])
    # @bleed = Bleed.find(flash[:bleed_id])
    # @raised_ink = RaisedInk.find(flash[:raised_ink_id])
    # @dimension = Dimension.find(flash[:dimension_id])
    # @paper_type = PaperType.find(flash[:paper_type_id])
    # @coating = Coating.find(flash[:coating_id])
    # @quantitie = Quantity.find(flash[:quantity_id])
    # @box_count = BoxCount.find(flash[:box_count_id])
    # @metal = Metal.find(flash[:metal_id])
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

end
