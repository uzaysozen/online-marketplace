class ListingsController < ApplicationController

    load_and_authorize_resource only: [:show, :edit, :update, :destroy]
    load_resource only: [:add_favourite, :delete_favourite, :start_conversation, :delete_conversation]

    # GET /listings
    def index
      @listings = Listing.accessible_by(current_ability)

      # Sorting Function
      table_col = Listing.column_names
      sort_val = ['asc', 'desc']
      
      # Verifying Parameters
      if table_col.include? params[:sort] and sort_val.include? session[:sort_order]
        sort_order = session[:sort_order] || 'asc'
        @listings = @listings.order("#{params[:sort]} #{sort_order}")
        session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
      else
        params[:sort] = "title"
        sort_order = 'asc'
        @listings = @listings.order("#{params[:sort]} #{sort_order}")
        session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
      end
    end

    def mylistings
      @listings = Listing.includes([:creator, :listing_condition]).accessible_by(current_ability, :update)
    end

    # GET /listings/1
    def show
      @listing = Listing.find(params[:id])
    end
  
    # GET /listings/new
    def new
      @listing = Listing.new
    end
  
    # GET /listings/1/edit
    def edit
      authorize! :update, @listing
      render layout: false
    end
  
    # POST /listings
    def create
      authorize! :create, Listing
      params = listing_params
      # take tags out of params, removing blank entries and duplicates
      tags = params.delete(:listing_tags).reject(&:blank?).map(&:upcase).uniq
      # take delivery methods out of params
      delivery_methods = params.delete(:listing_deliveries).reject(&:blank?)

      @listing = Listing.new(params)
      @listing.listing_status = ListingStatus.first
      @listing.creator_id = current_user.id
      @listing.is_active = true
      @listing.is_moderated = true
      @listing.receiver_id = current_user.id
      @listing.moderator_id = current_user.id

      tags.each do |tag|
        # create new tags, add to listing
        @listing.tags << Tag.where(name: tag).first_or_create
      end 
  
      delivery_methods.each do |delivery|
        # get delivery methods by id and add to listing
        @listing.deliveries << Delivery.where(id: delivery).first
      end

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
        render 'load_listings'
      end
    end

    def delete_favourite
      @favourite = @listing.user_favourites.find_by(user: current_user)
      @listings = Listing.all
      @favourite.destroy
      render 'load_listings'
    end


    def start_conversation
      authorize! :create, Conversation.new(listing: @listing)
      @conversation = current_user.conversations.find_or_create_by(listing: @listing, participant: current_user)
      redirect_to @conversation
    end

    def delete_conversation
      @conversation = current_user.conversations.find_by(listing: @listing)
      authorize! :delete, @conversation
      if @conversation.conversation_messages.empty?
        @conversation.destroy
        redirect_to listings_path
      else
        redirect_to listings_path
      end
    end

    private
      # Only allow a trusted parameter "white list" through.
      def listing_params
        params.require(:listing).permit(:title, :description, :price, :discounted_price, :location, :listing_condition_id, 
          :listing_category_id, :swap, :image, listing_tags: [], listing_deliveries: [])
      end
  end