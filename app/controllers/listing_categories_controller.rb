class ListingCategoriesController < ApplicationController
    before_action :set_listing_category, only: [:show, :edit, :update, :destroy]
  
    # GET /listing_categories
    def index
      @listing_categories = ListingCategory.all
    end
  
    # GET /listing_categories/1
    def show
    end
  
    # GET /listing_categories/new
    def new
      @listing_category = ListingCategory.new
    end
  
    # GET /listing_categories/1/edit
    def edit
    end
  
    # POST /listing_categories
    def create
      @listing_category = ListingCategory.new(listing_category_params)
  
      if @listing_category.save
        redirect_to listing_categories_path, notice: 'Listing category was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listing_categories/1
    def update
      if @listing_category.update(listing_category_params)
        redirect_to listing_categories_path, notice: 'Listing category was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listing_categories/1
    def destroy
      @listing_category.destroy
      redirect_to listing_categories_url, notice: 'Listing category was successfully deleted.'
    end
  
    # POST /listing_categories/search
    def search
      @listing_categories = ListingCategory.where(parent_id: params[:search][:parent_id])
      @listing_categories = @listing_categories.where(name: params[:search][:name]) if params[:search][:name].present?
      render :index
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing_category
        @listing_category = ListingCategory.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_category_params
        params.require(:listing_category).permit(:name)
      end
  end