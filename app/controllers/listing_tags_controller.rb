class ListingTagsController < ApplicationController
    # before_action :set_listing, only: [:show, :edit, :update, :destroy]
    
    # GET /listing_tags
    def index
      @listing_tags = ListingTags.all
    end
  
    # GET /listings/new
    def new
      @listing_tags = ListingTags.new
    end
  
  
    # POST /listings
    # def create
    #   @listing = Listing.new(listing_params)
    #   @listing.listing_status = ListingStatus.first
    #   @listing.creator_id = current_user.id
    #   @listing.is_active = true
    #   @listing.is_moderated = true
    #   @listing.receiver_id = current_user.id
    #   @listing.moderator_id = current_user.id

    #   print @listing.listing_status_id
  
    #   if @listing.save
    #     redirect_to listings_path, notice: 'Listing was successfully created.'
    #   else
    #     render :new
    #   end
    # end
  
    # # PATCH/PUT /listings/1
    # def update
    #   if @listing.update(listing_params)
    #     @listings = Listing.all
    #     render 'update_success'
    #   else
    #     render 'update_failure'
    #   end
    # end
  
    # # DELETE /listings/1
    # def destroy
    #   @listing.destroy
    #   redirect_to listings_url, notice: 'Listing was successfully deleted.'
    # end

    # # POST /products/search
    # def search
    #   @listings = Listing.all
    #   @listings = @listings.where("title like ?", "%#{params[:search][:search_title]}%") if params[:search][:search_title].present?
    #   render :index
    # end
  
    # private
    #   # Callback functions to share common setup or constraints between actions.
    #   def set_listing
    #     @listing = Listing.find(params[:id])
    #   end
  
    #   # Only allow a trusted parameter "white list" through.
    #   def listing_params
    #     params.require(:listing).permit(:title, :description, :price, :discounted_price, :location, :listing_condition_id, 
    #       :listing_category_id, :swap, :image)
    #   end
end