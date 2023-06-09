class ConversationMessagesController < ApplicationController
  load_resource only: [:report, :send_report, :show, :edit, :update, :destroy, :delete_message]
  # GET /conversation_messages
  def index
    @conversation_messages = ConversationMessage.all
  end

  # GET /conversation_messages/1
  def show
  end

  # GET /conversation_messages/new
  def new
    @conversation_message = ConversationMessage.new
  end

  # GET /conversation_messages/1/edit
  def edit
  end

  # POST /conversation_messages
  def send_message
    @conversation_message = ConversationMessage.new(conversation_message_params)
    @conversation_message.sender = current_user
    if @conversation_message.valid?
      @conversation_message.save
      SendConversationMessageJob.perform_later(@conversation_message, current_user)
      # emailing message if messages enabled by the receiver
      if current_user == @conversation_message.conversation.listing.creator
        if @conversation_message.conversation.participant.email_message
          UserMailer.message_email(@conversation_message.conversation.participant.email, "Message From " + current_user.username, @conversation_message.content).deliver
        end
      else
        if @conversation_message.conversation.listing.creator.email_message
          UserMailer.message_email(@conversation_message.conversation.listing.creator.email, "Message From " + current_user.username, @conversation_message.content).deliver
        end
      end
      head :ok
    else
      head :bad_request
    end
  end

  def delete_message
    @conversation_message.is_deleted = true
    @conversation_message.save
    DeleteConversationMessageJob.perform_later(@conversation_message.conversation, @conversation_message.id)
    head :ok
  end

  # PATCH/PUT /conversation_messages/1
  def update
    if @conversation_message.update(conversation_message_params)
      redirect_to conversation_messages_path, notice: 'Conversation message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /conversation_messages/1
  def destroy
    @conversation_message.destroy
    redirect_to conversation_messages_url, notice: 'Conversation message was successfully deleted.'
  end

  # POST /conversation_messages/search
  def search
    @conversation_messages = ConversationMessage.where(conversation_id: params[:search][:conversation_id], sender_id: params[:search][:sender_id])
    @conversation_messages = @conversation_messages.where(content: params[:search][:content]) if params[:search][:content].present?
    render :index
  end

  def report
    render layout: false
  end

  def send_report
    report_message = params[:report][:message]
    Report.create(message: report_message, conversation_message: @conversation_message, reporter: current_user)
  end

  private
    # Callback functions to share common setup or constraints between actions.
    def set_conversation_message
      @conversation_message = ConversationMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def conversation_message_params
      params.require(:conversation_message).permit(:content, :conversation_id)
    end
end