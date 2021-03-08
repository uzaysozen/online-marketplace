class CreateListingConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_conditions do |t|
      t.string :name, :limit => 50
      
      t.timestamps :created_at
      t.timestamps :updated_at
      t.timestamps
    end
  end
end
