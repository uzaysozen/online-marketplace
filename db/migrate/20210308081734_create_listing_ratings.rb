class CreateListingRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_ratings do |t|

      t.timestamps
    end
  end
end
