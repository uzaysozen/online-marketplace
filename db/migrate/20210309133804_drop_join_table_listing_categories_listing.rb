class DropJoinTableListingCategoriesListing < ActiveRecord::Migration[6.0]
  def change
    drop_table :listing_categories_listings
  end
end
