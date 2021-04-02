class FixListingRelations < ActiveRecord::Migration[6.0]
  def change
    change_table :listings do |t|
      t.remove :creator_id, :delivery_id, :listing_condition_id, :listing_status_id, :moderator_id, :receiver_id

      t.belongs_to :creator, foreign_key: { to_table: :users }
      t.belongs_to :moderator, foreign_key: { to_table: :users }
      t.belongs_to :receiver, foreign_key: { to_table: :users }

      t.belongs_to :listing_condition, foreign_key: "listing_condition_id"
      t.belongs_to :listing_status, foreign_key: "listing_status_id"
    end

    change_table :listing_views do |t|
      t.remove :listing_id, :user_id

      t.belongs_to :listing, foreign_key: "listing_id"
      t.belongs_to :user, foreign_key: "user_id"
    end

    change_table :listing_questions do |t|
      t.remove :listing_id

      t.belongs_to :listing, foreign_key: "listing_id"
    end

    change_table :listing_ratings do |t|
      t.remove :listing_id

      t.belongs_to :listing, foreign_key: "listing_id"
    end

    change_table :listing_deliveries do |t|
      t.remove :delivery_id, :listing_id

      t.belongs_to :delivery, foreign_key: "delivery_id"
      t.belongs_to :listing, foreign_key: "listing_id"
    end

    change_table :user_favourites do |t|
      t.remove :listing_id, :user_id

      t.belongs_to :listing, foreign_key: "listing_id"
      t.belongs_to :user, foreign_key: "user_id"
    end

    change_table :reports do |t|
      t.remove :conversation_message_id, :listing_id, :moderator_id, :user_id

      t.belongs_to :conversation_message, foreign_key: "conversation_message_id"
      t.belongs_to :listing, foreign_key: "listing_id"
      t.belongs_to :moderator, foreign_key: { to_table: :users }
      t.belongs_to :reporter, foreign_key: { to_table: :users }
    end
  end
end