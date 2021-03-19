class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy]
  
    # GET /listings
    def index
      @listings = Listing.all
    end
  
    # GET /listings/1
    def show
    end

    def mylistings
      @listings = Listing.where(creator_id: current_user.id)
    end
  
    # GET /listings/new
    def new
      @listing = Listing.new
    end
  
    # GET /listings/1/edit
    def edit
    end
  
    # POST /listings
    def create
      @listing = Listing.new(listing_params)
  
      if @listing.save
        redirect_to listings_path, notice: 'Listing was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listings/1
    def update
      if @listing.update(listing_params)
        redirect_to listings_path, notice: 'Listing was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listings/1
    def destroy
      @listing.destroy
      redirect_to listings_url, notice: 'Listing was successfully deleted.'
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing
        @listing = Listing.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_params
        #params.require(:listing).permit(:title, :description, :price, :discounted_price, :location, :images [])
        params.require(:listing).permit(:title, :description, :price, :creator_id, :receiver_id, :moderator_id,
          :listing_category_id, :listing_condition_id, :listing_status_id, :discounted_price, :location, :is_active, :is_moderated, images: [])
      end
  end