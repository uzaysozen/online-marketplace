class CreateConversationMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :conversation_messages do |t|
      t.boolean :is_deleted
      t.text :content
      t.bigint :conversation_id
      t.bigint :sender_id
      
      t.timestamps
    end
  end
end
