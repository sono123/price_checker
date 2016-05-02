class BoxCountsController < ApplicationController
  before_action :set_box_count, only: [:show, :edit, :update, :destroy]

  def index
    @box_counts = BoxCount.all
  end

  def show
  end

  def new
    @box_count = BoxCount.new
  end

  def edit
  end

  def create
    @box_count = BoxCount.new(box_count_params)

    respond_to do |format|
      if @box_count.save
        format.html { redirect_to box_counts_path, notice: 'Box count was successfully created.' }
        format.json { render :show, status: :created, location: @box_count }
      else
        format.html { render :new }
        format.json { render json: @box_count.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @box_count.update(box_count_params)
        format.html { redirect_to box_counts_path, notice: 'Box count was successfully updated.' }
        format.json { render :show, status: :ok, location: @box_count }
      else
        format.html { render :edit }
        format.json { render json: @box_count.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @box_count.destroy
    respond_to do |format|
      format.html { redirect_to box_counts_url, notice: 'Box count was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box_count
      @box_count = BoxCount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_count_params
      params.require(:box_count).permit(:box_count)
    end
end
