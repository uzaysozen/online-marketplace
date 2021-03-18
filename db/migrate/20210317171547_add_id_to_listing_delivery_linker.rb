class AddIdToListingDeliveryLinker < ActiveRecord::Migration[6.0]
  def change
    add_column :listing_deliveries, :listing_id, :bigint
    add_column :listing_deliveries, :delivery_id, :bigint
  end
end
