class CoatingsController < ApplicationController
  before_action :set_coating, only: [:show, :edit, :update, :destroy]

  # GET /coatings
  # GET /coatings.json
  def index
    @coatings = Coating.all
  end

  # GET /coatings/1
  # GET /coatings/1.json
  def show
  end

  # GET /coatings/new
  def new
    @coating = Coating.new
  end

  # GET /coatings/1/edit
  def edit
  end

  # POST /coatings
  # POST /coatings.json
  def create
    @coating = Coating.new(coating_params)

    respond_to do |format|
      if @coating.save
        format.html { redirect_to @coating, notice: 'Coating was successfully created.' }
        format.json { render :show, status: :created, location: @coating }
      else
        format.html { render :new }
        format.json { render json: @coating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coatings/1
  # PATCH/PUT /coatings/1.json
  def update
    respond_to do |format|
      if @coating.update(coating_params)
        format.html { redirect_to @coating, notice: 'Coating was successfully updated.' }
        format.json { render :show, status: :ok, location: @coating }
      else
        format.html { render :edit }
        format.json { render json: @coating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coatings/1
  # DELETE /coatings/1.json
  def destroy
    @coating.destroy
    respond_to do |format|
      format.html { redirect_to coatings_url, notice: 'Coating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coating
      @coating = Coating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coating_params
      params.require(:coating).permit(:front, :back)
    end
end
