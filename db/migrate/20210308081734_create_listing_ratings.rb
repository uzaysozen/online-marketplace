class CreateListingRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_ratings do |t|
      t.bigint :listing_id
      t.integer :seller_rating, :null => true
      t.integer :buyer_rating, :null => true

      t.timestamps :created_at
      t.timestamps :updated_at
      t.timestamps
    end
  end
end
