class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show edit update destroy ]

  def index
    @ratings = Rating.all
  end

  def show
  end

  def new
    @rating = Rating.new
  end

  def edit
  end

  def create
    @rating = Rating.new(rating_params)
    @rice = Rice.find(params[:rating][:rice_id])
  
    @rating.rice = @rice 
  
    respond_to do |format|
      if @rating.save
        @notification = Notification.new(user_id: @rice.user_id,title: "Rated Successfully!", message: "Your rice is successfully rated!")
        
        @notification.save
        format.html { redirect_to admin_path, notice: "Rating was successfully created." }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { redirect_to admin_path, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to rating_url(@rating), notice: "Rating was successfully updated." }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to ratings_url, notice: "Rating was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:rice_id, :age, :whiteness, :dryness, :pureness)
    end
end
