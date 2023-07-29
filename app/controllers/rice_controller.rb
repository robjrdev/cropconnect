class RiceController < ApplicationController
  before_action :set_rice, only: %i[ show edit update destroy ]

  def index
    @rice = Rice.all
  end

  def show
  end

  def new
    @rice = Rice.new
  end

  def edit
  end

  def create
    @rice = current_user.rices.new(rice_params)

    respond_to do |format|
      if @rice.save
        format.html { redirect_to farmer_path, notice: "Rice was successfully created." }
        format.json { render :show, status: :created, location: @rice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rice.update(rice_params)
        format.html { redirect_to rice_url(@rice), notice: "Rice was successfully updated." }
        format.json { render :show, status: :ok, location: @rice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rice.destroy

    respond_to do |format|
      format.html { redirect_to rice_index_url, notice: "Rice was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_rice
      @rice = Rice.find(params[:id])
    end

    def rice_params
      params.require(:rice).permit(:name, :bidding_price, :image)
    end
end
