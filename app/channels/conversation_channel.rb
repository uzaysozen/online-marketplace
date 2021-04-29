class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find_by_id(params[:conversation_id])
    if conversation
      if can? :read, Conversation
        stream_from "conversation_channel_#{params[:conversation_id]}"
      else
        connection.transmit identifier: params, error: "User is not authorized."
        reject
      end
    else
      connection.transmit identifier: params, error: "The conversation #{params[:conversation_id]} not found."
      reject
    end
  end
end
