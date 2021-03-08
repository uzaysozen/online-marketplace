class CreateListingImages < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_images do |t|

      t.timestamps
    end
  end
end
