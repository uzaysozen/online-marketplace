class SendConversationMessageJob < ApplicationJob
  queue_as :default

  def perform(message, user)
    html = ApplicationController.render(
      partial: 'conversation_messages/conversation_message', 
      locals: { message: message, user: user }
    )
    ActionCable.server.broadcast "conversation_channel_#{message.conversation_id}", html: html, message: message
  end
end
