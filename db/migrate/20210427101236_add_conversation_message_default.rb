class AddConversationMessageDefault < ActiveRecord::Migration[6.0]
  def up
    change_column_default(:conversation_messages, :is_deleted, false)
    change_column_null(:conversation_messages, :is_deleted, false)
  end
end
