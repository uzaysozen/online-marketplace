class AddListingIdColumnToListingImages < ActiveRecord::Migration[6.0]
  def change
    add_column :listing_images, :listing_id, :bigint
  end
end
