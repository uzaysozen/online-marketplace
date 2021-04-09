class CreateListingDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_deliveries do |t|
      t.string :name

      t.timestamps
    end
  end
end
