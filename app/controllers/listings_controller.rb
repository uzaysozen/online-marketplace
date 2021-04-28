class ListingsController < ApplicationController

    load_and_authorize_resource only: [:show, :edit, :update, :destroy]
    load_resource only: [:add_favourite, :complete, :delete_favourite, :swap, :swap_conversation, :start_conversation, :delete_conversation]

    # GET /listings
    def index
      @listings = accessible_listings
      session[:g_listings] = @listings

      # Sorting Function
      table_col = Listing.column_names
      sort_val = ['asc', 'desc']

      # Verifying Parameters
      if table_col.include? params[:sort] and sort_val.include? session[:sort_order]
        sort_order = session[:sort_order] || 'asc'
        @listings = session[:g_listings] ||= @listings
        @listings = @listings.order("#{params[:sort]} #{sort_order}")
        session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
      else
        params[:sort] = "title"
        sort_order = 'asc'
        @listings = session[:g_listings] ||= @listings
        @listings = @listings.order("#{params[:sort]} #{sort_order}")
        session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
      end
    end

    # POST /listings/search_and_filter
    def search_and_filter
      @listings = session[:g_listings] ||= accessible_listings

      # Search through Listings
      @listings = @listings.where("title ilike ?", "%#{params[:search_and_filter][:search_title]}%") if params[:search_and_filter][:search_title].present?

      #Filter by Category
      if params[:search_and_filter][:filter_category].present?
        current_category = ListingCategory.where(id: params[:search_and_filter][:filter_category]).first
        unless current_category.nil?
          subcategory_ids = current_category.explored.map(&:id)
          @listings = accessible_listings
          @listings = @listings.where(listing_category_id: subcategory_ids << current_category.id)
          session[:g_listings] = @listings
        end
      end

      #Filter by Minimum Price
      if params[:search_and_filter][:filter_minprice].present?
        @listings = @listings.where("price >= ?", params[:search_and_filter][:filter_minprice])
      end

      #Filter by Maximum Price
      if params[:search_and_filter][:filter_maxprice].present?
        @listings = @listings.where("price <= ?", params[:search_and_filter][:filter_maxprice])
      end

      #Filter by Condition
      if params[:search_and_filter][:filter_condition].present?
        current_condition = ListingCondition.where(id: params[:search_and_filter][:filter_condition]).first
        unless current_condition.nil?
          @listings = @listings.where(listing_condition_id: current_condition.id)
        end
      end

      #Filter by Delivery
      if params[:search_and_filter][:filter_delivery].present?
        delivery_ids = params[:search_and_filter][:filter_delivery]
        new_delivery_ids = delivery_ids.drop(1)

        current_delivery = Delivery.where(id: new_delivery_ids)
        unless current_delivery.nil?
          @listings = @listings.where(listing_deliveries: current_delivery.ids)
        end
      end

      if params[:clear_button]
        session[:sort_listings] = accessible_listings
        redirect_to listings_path
      else
        session[:sort_listings] = @listings
        render :index
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

    # GET /listings/1/swap
    def swap
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

      # Setting price to free if none was entered 
      if !@listing.price 
        @listing.price = 0.0
      end

      @listing.listing_status = ListingStatus.where(name: 'Pending').first
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
        @listings = active_listings
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
    
    def add_favourite
      @favourite = UserFavourite.new(listing: @listing, user: current_user)
      @listings = accessible_listings
      if @favourite.save
        render 'favourited_listing', locals: { listing: @listing, method: 'add' }
      end
    end

    # Mark listing as complete
    def complete 
      @listing.listing_status = ListingStatus.where(name: 'Complete').first

      if @listing.save
        redirect_to request.referrer, notice: 'Listing has been marked as complete'
      end
    end

    def delete_favourite
      @favourite = @listing.user_favourites.find_by(user: current_user)
      @listings = accessible_listings
      @favourite.destroy
      render 'favourited_listing', locals: {listing: @listing, method: 'remove' }
    end

    def start_conversation
      authorize! :create, Conversation.new(listing: @listing)
      @conversation = current_user.conversations.find_or_create_by(listing: @listing, participant: current_user)
      redirect_to @conversation
    end

    def swap_conversation
      authorize! :create, Conversation.new(listing: @listing)
      @conversation = current_user.conversations.find_or_create_by(listing: @listing, participant: current_user)
      swap = params[:swap_message]
      if !swap.nil?
        listing = Listing.find_by_id(swap[:item])
        return unless listing
        message = swap[:message] + ' (' + listing.title + ')'
        ConversationMessage.create(conversation: @conversation, content: message, sender: current_user)
        redirect_to @conversation
      end
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
      def accessible_listings
        Listing.includes(:creator, :listing_condition).accessible_by(current_ability)
      end
      # Only allow a trusted parameter "white list" through.
      def listing_params
        params.require(:listing).permit(:title, :description, :price, :discounted_price, :location, :listing_condition_id, 
          :listing_category_id, :swap, images: [], listing_tags: [], listing_deliveries: [])
      end
  end