class CreateListingViews < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_views do |t|
      t.bigint :user_id
      t.bigint :listing_id
      
      t.timestamps :created_at
      t.timestamps :updated_at
      t.timestamps
    end
  end
end
