class MetalsController < ApplicationController
  before_action :set_metal, only: [:show, :edit, :update, :destroy]

  def index
    @metals = Metal.all
  end

  def show
  end

  def new
    @metal = Metal.new
  end

  def edit
  end

  def create
    @metal = Metal.new(metal_params)

    respond_to do |format|
      if @metal.save
        format.html { redirect_to metals_path, notice: 'Metal was successfully created.' }
        format.json { render :show, status: :created, location: @metal }
      else
        format.html { render :new }
        format.json { render json: @metal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @metal.update(metal_params)
        format.html { redirect_to metals_path, notice: 'Metal was successfully updated.' }
        format.json { render :show, status: :ok, location: @metal }
      else
        format.html { render :edit }
        format.json { render json: @metal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @metal.destroy
    respond_to do |format|
      format.html { redirect_to metals_url, notice: 'Metal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metal
      @metal = Metal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metal_params
      params.require(:metal).permit(:front, :back)
    end
end
