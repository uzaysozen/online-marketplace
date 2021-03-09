class CreateJoinTableListingCategoriesListings < ActiveRecord::Migration[6.0]
  def change
    create_join_table :listing_categories, :listings do |t|
      t.index [:listing_category_id, :listing_id], name: 'category_listing_index'
      t.index [:listing_id, :listing_category_id], name: 'listing_category_index'
    end
  end
end
