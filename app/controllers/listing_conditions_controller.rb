class ListingConditionsController < ApplicationController
    before_action :set_listing_condition, only: [:show, :edit, :update, :destroy]
  
    # GET /listing_conditions
    def index
      @listing_conditions = ListingCondition.all
    end
  
    # GET /listing_conditions/1
    def show
    end
  
    # GET /listing_conditions/new
    def new
      @listing_condition = ListingCondition.new
    end
  
    # GET /listing_conditions/1/edit
    def edit
    end
  
    # POST /listing_conditions
    def create
      @listing_condition = ListingCondition.new(listing_condition_params)
  
      if @listing_condition.save
        redirect_to listing_conditions_path, notice: 'Listing Condition was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listing_conditions/1
    def update
      if @listing_condition.update(listing_condition_params)
        redirect_to listing_conditions_path, notice: 'Listing Condition was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listing_conditions/1
    def destroy
      @listing_condition.destroy
      redirect_to listing_conditions_url, notice: 'Listing Condition was successfully deleted.'
    end
  
    # POST /listing_conditions/search
    def search
      @listing_conditions = ListingCondition.all
      @listing_conditions = @listing_conditions.where(name: params[:search][:name]) if params[:search][:name].present?
      render :index
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing_condition
        @listing_condition = ListingCondition.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_condition_params
        params.require(:listing_condition).permit(:name)
      end
  end