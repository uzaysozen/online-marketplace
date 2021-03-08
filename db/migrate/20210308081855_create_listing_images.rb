class CreateListingImages < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_images do |t|
      t.string :image_path, :limit => 50

      t.timestamps
    end
  end
end
