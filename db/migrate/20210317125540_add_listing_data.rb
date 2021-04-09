class AddListingData < ActiveRecord::Migration[6.0]
  def change
    create_table :listings_delivery do |t|
      t.string :name, :limit => 50
      t.timestamps
    end
    
    add_column :listings, :delivery_id, :bigint
    add_column :listings, :swap, :boolean
  end
end
