class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy, :add_favourite, :delete_favourite, :start_conversation]
    
    # GET /listings
    def index
      @listings = Listing.all

      # Sorting Function
      table_col = Listing.column_names
      sort_val = ['asc', 'desc']
      
      # Verifying Parameters
      if table_col.include? params[:sort] and sort_val.include? session[:sort_order]
        sort_order = session[:sort_order] || 'asc'
        @listings = Listing.order("#{params[:sort]} #{sort_order}")
        session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
      else
        params[:sort] = "title"
        sort_order = 'asc'
        @listings = Listing.order("#{params[:sort]} #{sort_order}")
        session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
      end
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
      @listings = @listings.where("title ilike ?", "%#{params[:search][:search_title]}%") if params[:search][:search_title].present?
      render :index
    end
    
    def add_favourite
      @favourite = UserFavourite.new(listing: @listing, user: current_user)
      @listings = Listing.all
      if @favourite.save
        render 'load_listings', notice: 'Listing was successfully added to the favourites.'
      end
    end

    def delete_favourite
      @favourite = @listing.user_favourites.find_by(user: current_user)
      @listings = Listing.all
      @favourite.destroy
      render 'load_listings'
    end


    def start_conversation
      @conversation = current_user.conversations.find_or_create_by(listing: @listing, participant: current_user)
      @messages = @conversation.conversation_messages.where(is_deleted: nil)
    end

    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing
        @listing = Listing.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_params
        params.require(:listing).permit(:title, :description, :price, :discounted_price, :location, :listing_condition_id, 
          :listing_category_id, :swap, :listing_status_id, :is_active, :is_moderated, :creator_id, :receiver_id, :moderator_id)
      end
  end