class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy]
    
    # GET /listings
    def index
      @listings = Listing.all
    end

    def mylistings
      @listings = Listing.profile(current_user)
    end
  
    # GET /listings/1
    def show
    end
  
    # GET /listings/new
    def new
      @listing = Listing.new
    end
  
    # GET /listings/1/edit
    def edit
      render layout: false
    end
  
    # POST /listings
    def create
      tags = listing_params[:listing_tags]
      print "\n \n \n \n"
      print tags
      print "\n \n \n \n"
      listing_params.delete(:listing_tags)

      print "\n \n \n \n"
      print listing_params[:listing_tags]
      print "\n \n \n \n"

      @listing = Listing.new(listing_params)
      @listing.listing_status = ListingStatus.first
      @listing.creator_id = current_user.id
      @listing.is_active = true
      @listing.is_moderated = true
      @listing.receiver_id = current_user.id
      @listing.moderator_id = current_user.id

      
  
      if @listing.save
        redirect_to listings_path, notice: 'Listing was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listings/1
    def update
      if @listing.update(listing_params)
        @listings = Listing.all
        render 'update_success'
      else
        render 'update_failure'
      end
    end
  
    # DELETE /listings/1
    def destroy
      @listing.destroy
      redirect_to listings_url, notice: 'Listing was successfully deleted.'
    end

    # POST /products/search
    def search
      @listings = Listing.all
      @listings = @listings.where("title like ?", "%#{params[:search][:search_title]}%") if params[:search][:search_title].present?
      render :index
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing
        @listing = Listing.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_params
        params.require(:listing).permit(:title, :description, :price, :discounted_price, :location, :listing_condition_id, 
          :listing_category_id, :swap, :image, listing_tags: [])
      end
  end