class SendConversationMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    my = ApplicationController.render(
      partial: 'conversation_messages/my_message', 
      locals: { message: message }
    )

    their = ApplicationController.render(
      partial: 'conversation_messages/their_message', 
      locals: { message: message }
    )
    ActionCable.server.broadcast "conversation_channel_#{message.conversation_id}", my: my, their: their, message: message
  end
end
