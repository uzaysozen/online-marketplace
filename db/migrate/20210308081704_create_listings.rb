class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.boolean :is_active
      t.boolean :is_moderated
      t.string :title, :limit => 50
      t.text :description
      t.decimal :price
      t.decimal :discounted_price, :null => true
      t.string :location, :limit => 50
      t.bigint :creator_id
      t.bigint :moderator_id
      t.bigint :receiver_id
      t.bigint :listing_status_id
      t.bigint :listing_condition_id
      t.bigint :category_id

      t.timestamps :created_at
      t.timestamps :updated_at
      t.timestamps
    end
  end
end
