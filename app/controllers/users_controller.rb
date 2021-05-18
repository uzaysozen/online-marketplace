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
      if params[:settings][:email_message] == "1"
        current_user.update(email_message: true)
      else
        current_user.update(email_message: false)
      end
      
      if params[:settings][:email_category] == "1"
        current_user.update(email_category: true)
      else
        current_user.update(email_category: false)
      end

      if params[:settings][:categories].present?
        current_user.update(user_categories: params[:settings][:categories])
      end
      
      if params[:settings][:when].present?
        current_user.update(when: params[:settings][:when])
      end
    end

    def reviews
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