class AddConversationRelations < ActiveRecord::Migration[6.0]
  def change
    change_table :conversations do |t|
      t.remove :listing_id, :participant_id

      t.belongs_to :listing, foreign_key: "listing_id"
      t.belongs_to :participant, foreign_key: { to_table: :users }
    end

    change_table :conversation_messages do |t|
      t.remove :conversation_id, :sender_id
      
      t.belongs_to :conversation, foreign_key: "conversation_id"
      t.belongs_to :sender, foreign_key: { to_table: :users }
    end
  end
end
