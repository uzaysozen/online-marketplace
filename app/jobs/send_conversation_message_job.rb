class SendConversationMessageJob < ApplicationJob
  queue_as :default

  def perform(message, current_user)
    html = ApplicationController.render(
      partial: 'conversation_messages/conversation_message', 
      locals: { message: message, current_user: current_user }
    )
    ActionCable.server.broadcast "conversation_channel_#{message.conversation_id}", html: html, message: message
  end
end
