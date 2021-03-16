class ConversationMessagesController < ApplicationController
    before_action :set_conversation_message, only: [:show, :edit, :update, :destroy]
  
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
    def create
      @conversation_message = ConversationMessage.new(conversation_message_params)
      @conversation_message.sender = current_user
      @conversation_message.save
      SendConversationMessageJob.perform_later(@conversation_message)
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