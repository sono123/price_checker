class DimensionsController < ApplicationController
  before_action :set_dimension, only: [:show, :edit, :update, :destroy]

  # GET /dimensions
  # GET /dimensions.json
  def index
    @dimensions = Dimension.all
  end

  # GET /dimensions/new
  def new
    @dimension = Dimension.new
  end

  # GET /dimensions/1/edit
  def edit
  end

  # POST /dimensions
  # POST /dimensions.json
  def create
    @dimension = Dimension.new(dimension_params)

    respond_to do |format|
      if @dimension.save
        format.html { redirect_to dimensions_path, notice: 'Dimension was successfully created.' }
        format.json { render :index, status: :created, location: @dimension }
      else
        format.html { render :new }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dimensions/1
  # PATCH/PUT /dimensions/1.json
  def update
    respond_to do |format|
      if @dimension.update(dimension_params)
        format.html { redirect_to dimensions_path, notice: 'Dimension was successfully updated.' }
        format.json { render :show, status: :ok, location: @dimension }
      else
        format.html { render :edit }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dimensions/1
  # DELETE /dimensions/1.json
  def destroy
    @dimension.destroy
    respond_to do |format|
      format.html { redirect_to dimensions_url, notice: 'Dimension was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dimension
      @dimension = Dimension.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dimension_params
      params.require(:dimension).permit(:width, :height)
    end
end
