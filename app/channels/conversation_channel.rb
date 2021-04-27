class ConversationChannel < ApplicationCable::Channel
  def subscribed
    puts current_user.id
    puts "\n\n\n\n\n\n\n"
    stream_from "conversation_channel_#{params[:conversation_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
