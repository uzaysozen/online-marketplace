class CreateUserFavourites < ActiveRecord::Migration[6.0]
  def change
    create_table :user_favourites do |t|
      t.bigint :listing_id
      t.bigint :user_id
      
      t.timestamps :created_at
      t.timestamps :updated_at
      t.timestamps
      t.timestamps
    end
  end
end
