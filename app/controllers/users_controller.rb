class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
  
    # GET /users
    def index
      @users = User.all
    end
  
    # GET /users/1
    def show
    end
  
    # GET /users/1/edit
    def edit
    end
  
    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    # POST /users/search
    def search
        @users = User.where(email: params[:search][:email])
        @users = @users.where(username: params[:search][:username]) if params[:search][:username].present?
        @users = @users.where(sn: params[:search][:sn]) if params[:search][:sn].present?
        @users = @users.where(givenname: params[:search][:givenname]) if params[:search][:givenname].present?
        @users = @users.where(ban_reason: params[:search][:ban_reason]) if params[:search][:ban_reason].present?
        render :index
    end

    def settings
      @user_categories = current_user.user_categories.sort
      @email_message = current_user.email_message
      @email_category = current_user.email_category
      if current_user.when == 'immediately'
        @when = ['Immediately', 'immediately']
      elsif current_user.when == 'weekly'
        @when = ['Weekly', 'weekly']
      elsif current_user.when == 'monthly'
        @when = ['Monthly', 'monthly']
      else
        @when = []
      end
    end

    def settings_update
      # Set variables
      user_time = params[:settings][:when]
      email_message = params[:settings][:email_message]
      email_category = params[:settings][:email_category]
      user_categories = params[:settings][:categories]
      # Update user settings
      if email_message == "1"
        current_user.update(email_message: true)
      else
        current_user.update(email_message: false)
      end
      
      if email_category == "1"
        current_user.update(email_category: true)
      else
        current_user.update(email_category: false)
      end

      if user_categories.present?
        current_user.update(user_categories: user_categories)
      end
      
      if user_time.present?
        current_user.update(when: user_time)
      end
      # Send scheduled email
      if user_time == 'weekly' and email_category == "1"
        # Enqueue a job to be performed 1 week from now.
        SendEmailNotificationJob.set(wait: 1.week).perform_later(current_user, user_categories, user_time)
      elsif user_time == 'monthly' and email_category == "1"
        # Enqueue a job to be performed 1 month from now.
        SendEmailNotificationJob.set(wait: 1.month).perform_later(current_user, user_categories, user_time)
      end
    end

    def reviews
      received_items = Listing.where(receiver_id: current_user.id, listing_status: ListingStatus.find_by(name: 'Complete'))
      @received_items_reviews = ListingRating.where(listing_id: received_items.ids).where.not(buyer_rating: nil)

      given_items = Listing.where(creator_id: current_user.id, listing_status: ListingStatus.find_by(name: 'Complete')).where.not(receiver_id: nil)
      @given_items_reviews = ListingRating.where(listing_id: given_items.ids)

      @review_items = Listing.joins('LEFT OUTER JOIN listing_ratings ON listings.id = listing_ratings.listing_id').where("(listings.creator_id = #{current_user.id} 
        AND listing_ratings.buyer_rating IS NULL AND listings.receiver_id IS NOT NULL) OR (listings.receiver_id = #{current_user.id} AND listing_ratings.seller_rating IS NULL)").where(listing_status: ListingStatus.find_by(name: 'Complete'))
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:email, :username, :sn, :givenname, :ban_reason)
      end
  end