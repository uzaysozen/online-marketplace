class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.save
    ActionCable.server.broadcast 'messages_channel', content: @message.content, count: Message.all.count
  end

  private

  # Only allow a trusted parameter "white list" through.
  def message_params
    params.require(:message).permit(:content)
  end
end
