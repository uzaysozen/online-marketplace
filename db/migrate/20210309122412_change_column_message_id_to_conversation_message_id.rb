class ChangeColumnMessageIdToConversationMessageId < ActiveRecord::Migration[6.0]
  def change
    rename_column :reports, :message_id, :conversation_message_id
  end
end
