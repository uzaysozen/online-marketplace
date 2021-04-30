class AddSwapListingToConversationMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :conversation_messages, :swap_listing_id, :bigint
    add_foreign_key :conversation_messages, :listings, column: :swap_listing_id
    add_index :conversation_messages, :swap_listing_id
  end
end
