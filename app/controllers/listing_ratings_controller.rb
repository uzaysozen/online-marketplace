class ListingRatingsController < ApplicationController
    before_action :set_listing_rating, only: [:show, :edit, :update, :destroy]
  
    # GET /listing_ratings
    def index
      @listing_ratings = ListingRating.all
    end
  
    # GET /listing_ratings/1
    def show
    end
  
    # GET /listing_ratings/new
    def new
      @listing_rating = ListingRating.new
    end
  
    # GET /listing_ratings/1/edit
    def edit
    end
  
    # POST /listing_ratings
    def create
      @listing_rating = ListingRating.new(listing_rating_params)
  
      if @listing_rating.save
        redirect_to listing_ratings_path, notice: 'Listing rating was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listing_ratings/1
    def update
      if @listing_rating.update(listing_rating_params)
        redirect_to listing_ratings_path, notice: 'Listing rating was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listing_ratings/1
    def destroy
      @listing_rating.destroy
      redirect_to listing_ratings_url, notice: 'Listing rating was successfully deleted.'
    end
  
    # POST /listing_ratings/search
    def search
      @listing_ratings = ListingRating.where(listing_id: params[:search][:listing_id])
      @listing_ratings = @listing_ratings.where(buyer_rating: params[:search][:buyer_rating]) if params[:search][:buyer_rating].present?
      @listing_ratings = @listing_ratings.where(seller_rating: params[:search][:seller_rating]) if params[:search][:seller_rating].present?
      render :index
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing_rating
        @listing_rating = ListingRating.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_rating_params
        params.require(:listing_rating).permit(:buyer_rating, :seller_rating)
      end
  end