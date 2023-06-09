class UserFavouritesController < ApplicationController
    before_action :set_user_favourite, only: [:show, :destroy]
  
    # GET /user_favourites
    def index
      @favourite_listings = current_user.favourites
    end
  
    # GET /user_favourites/1
    def show
    end
  
    # GET /user_favourites/new
    def new
      @user_favourite = UserFavourite.new
    end
  
    # POST /user_favourites
    def create
      @user_favourite = UserFavourite.new(user_favourite_params)
  
      if @user_favourite.save
        redirect_to user_favourites_path, notice: 'User favourite was successfully created.'
      else
        render :new
      end
    end
  
    # DELETE /user_favourites/1
    def destroy
      @user_favourite.destroy
      @favourite_listings = current_user.favourites
      render 'remove_favourite'
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_user_favourite
        @user_favourite = UserFavourite.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def user_favourite_params
        params.require(:user_favourite)
      end
  end