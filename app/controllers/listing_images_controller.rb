class ListingImagesController < ApplicationController
    before_action :set_ListingImage, only: [:show, :edit, :update, :destroy]
  
    # GET /listing_images
    def index
      @listing_images = ListingImage.all
    end
  
    # GET /listing_images/1
    def show
    end
  
    # GET /listing_images/new
    def new
      @listing_image = ListingImage.new
    end
  
    # GET /listing_images/1/edit
    def edit
    end
  
    # POST /listing_images
    def create
      @listing_image = ListingImage.new(listing_image_params)
  
      if @listing_image.save
        redirect_to listing_images_path, notice: 'Listing image was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /listing_images/1
    def update
      if @listing_image.update(listing_image_params)
        redirect_to listing_images_path, notice: 'Listing image was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /listing_images/1
    def destroy
      @listing_image.destroy
      redirect_to listing_images_url, notice: 'Listing image was successfully deleted.'
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_listing_image
        @listing_image = ListingImage.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def listing_image_params
        params.require(:ListingImage).permit(:image_path)
      end
  end