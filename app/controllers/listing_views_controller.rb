class ListingViewsController < ApplicationController
    before_action :set_listing_view, only: [:show, :edit, :update, :destroy]
  
    # GET /listing_views
    def index
      @listing_views = ListingView.all
    end
  
    # GET /listing_views/1
    def show
    end
  
    # GET /listing_views/new
    def new
      @listing_view = ListingView.new
    end
  
    # GET /listing_views/1/edit
    def edit
    end
  
    # POST /listing_views
    def create
      @listing_view = ListingView.new(listing_view_params)
  
      if @listing_view.save
        redirect_to listing_views_path, notice: 'Listing view was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listing_views/1
    def update
      if @listing_view.update(listing_view_params)
        redirect_to listing_views_path, notice: 'Listing view was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listing_views/1
    def destroy
      @listing_view.destroy
      redirect_to listing_views_url, notice: 'Listing view was successfully deleted.'
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing_view
        @listing_view = ListingView.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_view_params
        params.require(:listing_view)
      end
  end