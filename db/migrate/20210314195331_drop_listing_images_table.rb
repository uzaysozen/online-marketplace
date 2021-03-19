class DropListingImagesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :listing_images
  end
end
