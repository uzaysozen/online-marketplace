class DeleteConversationMessageJob < ApplicationJob
  queue_as :default

  def perform(conversation, message_id)
    ActionCable.server.broadcast "conversation_channel_#{conversation.id}", message_id: message_id
  end
end
