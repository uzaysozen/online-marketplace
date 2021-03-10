class ListingStatusesController < ApplicationController
    before_action :set_listing_status, only: [:show, :edit, :update, :destroy]
  
    # GET /listing_statuses
    def index
      @listing_statuses = ListingStatus.all
    end
  
    # GET /listing_statuses/1
    def show
    end
  
    # GET /listing_statuses/new
    def new
      @listing_status = ListingStatus.new
    end
  
    # GET /listing_statuses/1/edit
    def edit
    end
  
    # POST /listing_statuses
    def create
      @listing_status = ListingStatus.new(listing_status_params)
  
      if @listing_status.save
        redirect_to listing_statuses_path, notice: 'Listing Status was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listing_statuses/1
    def update
      if @listing_status.update(listing_status_params)
        redirect_to listing_statuses_path, notice: 'Listing Status was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listing_statuses/1
    def destroy
      @listing_status.destroy
      redirect_to listing_statuss_url, notice: 'Listing Status was successfully deleted.'
    end
  
    # POST /listing_statuses/search
    def search
      @listing_statuses = ListingStatus.all
      @listing_statuses = @listing_statuses.where(name: params[:search][:name]) if params[:search][:name].present?
      render :index
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing_status
        @listing_status = ListingStatus.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_status_params
        params.require(:listing_status).permit(:name)
      end
  end