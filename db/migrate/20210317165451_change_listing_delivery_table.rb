class ChangeListingDeliveryTable < ActiveRecord::Migration[6.0]
  def up 
    remove_column :listing_deliveries, :name
  end

  def down 
    add_column :listing_deliveries, :listing_id, :bigint
    add_column :listing_deliveries, :delivery_id, :bigint
  end 
end
