class CreateConversationMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :conversation_messages do |t|

      t.timestamps
    end
  end
end
