class ListingsController < ApplicationController
  load_and_authorize_resource only: [:show, :edit, :update, :destroy]
  load_resource only: [:report, :send_report, :add_favourite, :delete_favourite, :start_conversation, :delete_conversation, :complete, :swap, :swap_conversation, :rating, :add_rating]

  # GET /listings
  def index
    @listings = accessible_listings
    session[:category_listings] = accessible_listings

    # Initializing variables for the filter menu to remember filter settings
    session[:search_string] = ""
    session[:search_category] = ""
    session[:search_minprice] = ""
    session[:search_maxprice] = ""
    session[:search_condition] = ""
    session[:search_swap] = false

    # Sorting Function
    table_col = Listing.column_names
    sort_val = ['asc', 'desc']

    # Verifying Parameters
    if table_col.include? params[:sort] and sort_val.include? session[:sort_order]
      sort_order = session[:sort_order] || 'asc'
      @listings = session[:sort_listings] ||= accessible_listings
      @listings = @listings.order("#{params[:sort]} #{sort_order}")
      session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
    else
      params[:sort] = "title"
      sort_order = 'asc'
      @listings = session[:sort_listings] ||= accessible_listings
      @listings = @listings.order("#{params[:sort]} #{sort_order}")
      session[:sort_order] = sort_order == 'asc' ? 'desc' : 'asc'
    end
  end

  # POST /listings/search_and_filter
  def search_and_filter
    @listings = session[:category_listings] ||= accessible_listings

    # Filter by Category
    if params[:search_and_filter][:filter_category].present?
      current_category = ListingCategory.where(id: params[:search_and_filter][:filter_category]).first
      unless current_category.nil?
        subcategory_ids = current_category.explored.map(&:id)
        @listings = accessible_listings
        @listings = @listings.where(listing_category_id: subcategory_ids << current_category.id)
        session[:category_listings] = @listings
        session[:search_category] = params[:search_and_filter][:filter_category]
      end
    else
      session[:search_category] = ""
      session[:category_listings] = accessible_listings
      @listings = accessible_listings
    end

    # Filter the Listings by Tags
    if params[:search_and_filter][:filter_tags].present?
      @entered_tags = params[:search_and_filter][:filter_tags].reject(&:blank?)
      @all_tag_names = Tag.pluck(:name)

      if not (@all_tag_names & @entered_tags).empty?
        @common_tags = @all_tag_names & @entered_tags
        @tag_objects = Tag.where(name: @common_tags)
        @listing_tag_objects = ListingTag.where(tag_id: @tag_objects.ids)

        unless @listing_tag_objects.nil?
          @listings = @listings.where(id: @listing_tag_objects.listing_id)
        end
      end
    end

    # Search through Listings
    if params[:search_and_filter][:search_bar].present?
      @search_params = params[:search_and_filter][:search_bar]
      @listing_locations = Listing.pluck(:location)
      if @listing_locations.include? @search_params
        @listings = @listings.where("location = ?", "#{params[:search_and_filter][:search_bar]}")
        session[:search_string] = @search_params
      else
        @listings = @listings.where("title ilike ?", "%#{params[:search_and_filter][:search_bar]}%")
        session[:search_string] = @search_params
      end
    else
      session[:search_string] = ""
    end

    # Filter by Minimum Price
    if params[:search_and_filter][:filter_minprice].present?
      @listings = @listings.where("price >= ?", params[:search_and_filter][:filter_minprice])
      session[:search_minprice] = params[:search_and_filter][:filter_minprice]
    else
      session[:search_minprice] = ""
    end

    # Filter by Maximum Price
    if params[:search_and_filter][:filter_maxprice].present?
      @listings = @listings.where("price <= ?", params[:search_and_filter][:filter_maxprice])
      session[:search_maxprice] = params[:search_and_filter][:filter_maxprice]
    else
      session[:search_maxprice] = ""
    end

    # Filter by Condition
    if params[:search_and_filter][:filter_condition].present?
      current_condition = ListingCondition.where(id: params[:search_and_filter][:filter_condition]).first
      session[:search_condition] = params[:search_and_filter][:filter_condition]
      unless current_condition.nil?
        @listings = @listings.where(listing_condition_id: current_condition.id)
      end
    else
      session[:search_condition] = ""
    end

    # Filter by Swap-Only Listings
    if params[:search_and_filter][:filter_swap] == "1"
      @listings = @listings.where("swap = ?", params[:search_and_filter][:filter_swap])
      session[:search_swap] = true
    else
      session[:search_swap] = false
    end

    # Filter by Delivery
    if params[:search_and_filter][:filter_delivery].present?
      delivery_ids = params[:search_and_filter][:filter_delivery]
      new_delivery_ids = delivery_ids.drop(1)

      # Checking if array is empty
      @empty_del = false
      @delivery_numbers = ["1", "2", "3"]
      if (new_delivery_ids & @delivery_numbers).empty?
        @empty_del = true
      end

      current_delivery = Delivery.where(id: new_delivery_ids)
      current_listing_delivery = ListingDelivery.where(delivery_id: current_delivery.ids)

      unless current_delivery.nil? || @empty_del
        @listings = @listings.where(listing_deliveries: current_listing_delivery)
      end
    end

    if params[:search_button] != 'Clear'
      session[:sort_listings] = @listings
      render :index
    else
      @listings = accessible_listings
      session[:sort_listings] = accessible_listings
      session[:category_listings] = accessible_listings
      session[:search_string] = ""
      session[:search_category] = ""
      session[:search_minprice] = ""
      session[:search_maxprice] = ""
      session[:search_condition] = ""
      session[:search_swap] = false
      render :index
    end
  end

  def mylistings
    @listings = Listing.includes([:creator, :listing_condition, :images_attachments]).accessible_by(current_ability, :update)
  end

  # GET /listings/1
  def show
    @listing = Listing.find(params[:id])
    @user_listings_count = Listing.where(creator: current_user, listing_status: ListingStatus.find_by(name: 'Active')).count
    ListingView.create(listing: @listing, user: current_user)
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
    if !@listing.price?
      @listing.price = 0.0
    end
    @listing.listing_status = ListingStatus.first
    @listing.creator_id = current_user.id

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
    params = listing_params
    # take tags and delivery methods out of params, removing blank entries and duplicates
    tags = params.delete(:listing_tags).reject(&:blank?).map(&:upcase).uniq
    delivery_methods = params.delete(:listing_deliveries).reject(&:blank?)

    if @listing.update(params)
      # Clearing the listing's current tags
      @listing.tags = []

      tags.each do |tag|
        # create new tags, add to listing
        @listing.tags << Tag.where(name: tag).first_or_create
      end

      delivery_methods.each do |delivery|
        # get delivery methods by id and add to listing
        @listing.deliveries << Delivery.where(id: delivery).first
      end

      if @listing.save
        @listings = Listing.includes([:creator, :listing_condition]).accessible_by(current_ability, :update)
        render 'update_success'
      end
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

  def delete_favourite
    @favourite = @listing.user_favourites.find_by(user: current_user)
    @listings = accessible_listings
    @favourite.destroy
    render 'favourited_listing', locals: {listing: @listing, method: 'remove' }
  end

  def start_conversation
    authorize! :create, Conversation.new(listing: @listing)
    @conversation = current_user.conversations.find_or_create_by(listing: @listing, participant: current_user)
    if params[:swap].present?
      redirect_to @conversation, notice: params[:swap]
    else
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

  def swap
    @user_listings = Listing.where(creator: current_user, listing_status: ListingStatus.find_by(name: 'Active'))
    render layout: false
  end

  def swap_conversation
    message = params[:swap_message][:message]
    @conversation = current_user.conversations.find_or_create_by(listing: @listing, participant: current_user)
    @conversation_message = ConversationMessage.new(conversation: @conversation, content: message)
    @conversation_message.sender = current_user
    @conversation_message.swap_listing_id = params[:swap_message][:item]
    if @conversation_message.valid?
      @conversation_message.save
      SendConversationMessageJob.perform_later(@conversation_message, current_user)
      head :ok
    else
      head :bad_request
    end
  end

  # Mark listing as complete
  def complete
    @listing.listing_status = ListingStatus.where(name: 'Complete').first
    if params[:receiver].present?
      @listing.receiver = User.find_by_id(params[:receiver])
      print "test"
      puts @listing.receiver.username
    end

    print 
    
    if @listing.save
      redirect_to request.referrer, notice: 'Listing has been marked as complete'
    else
      print @listing.errors.full_messages
      redirect_to request.referrer, notice: 'Failed to complete listing'
    end

  end

  def rating
    render layout: false
  end

  def add_rating
    rating_params = params[:rating_form]
    # Find or create listing rating
    @listing_rating = ListingRating.find_or_create_by(listing_id: @listing.id)

    # Check user is seller or buyer
    if current_user == @listing.creator
      # seller
      @listing_rating.seller_rating = rating_params[:rating]
      @listing_rating.seller_comment = rating_params[:comment]
      @listing_rating.seller_anon = rating_params[:anonymous] == '1'
      rated_user = User.find_by_id(@listing.receiver_id)
    else
      # buyer
      @listing_rating.buyer_rating = rating_params[:rating]
      @listing_rating.buyer_comment rating_params[:comment]
      @listing_rating.buyer_anon = rating_params[:anonymous] == '1'
      rated_user = @listing.creator
    end

    if @listing_rating.save
      n_rating = 0
      # find receiver ratings
      listings = Listing.where(receiver_id: rated_user.id).all
      n_rating = listings.size()
      
      # add to total rating
      total_rating = 0
      for listing in listings do
        if listing.listing_rating.present? and listing.listing_rating.buyer_rating.present?
          total_rating += listing.listing_rating.buyer_rating
          n_rating += 1
        end
      end

      # find seller ratings
      listings = Listing.where(creator_id: rated_user).where.not(receiver_id: nil).all
      n_rating += listings.size()
      
      # add to total rating
      for listing in listings do
        if listing.listing_rating.present? and listing.listing_rating.seller_rating.present?
          total_rating += listing.listing_rating.seller_rating
          n_rating += 1
        end
      end

      # save total rating
      rated_user.rating = total_rating / n_rating
      rated_user.rating_count = n_rating

      # save user
      if rated_user.save()
        head :ok
      else
        head :bad_request
      end
    else
      head :bad_request
    end
  end

  def report
    render layout: false
  end

  def send_report
    report_message = params[:report][:message]
    Report.create(message: report_message, listing: @listing, reporter: current_user)
  end

  private
    def accessible_listings
      Listing.includes(:creator, :listing_condition).accessible_by(current_ability, :list)
    end
    # Only allow a trusted parameter "white list" through.
    def listing_params
      params.require(:listing).permit(:title, :description, :price, :discounted_price, :location, :listing_condition_id,
                                      :listing_category_id, :swap, images: [], listing_tags: [], listing_deliveries: [])
    end
end