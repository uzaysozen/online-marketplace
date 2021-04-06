class ConversationsController < ApplicationController
    before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  
    # GET /conversations
    def index
      @sent = Conversation.profile(current_user)
      listings = Listing.profile(current_user)
      @received = []
      listings.each do |listing|
        @received += listing.conversations
      end
    end
  
    # GET /conversations/1
    def show
      @messages = @conversation.conversation_messages.where(is_deleted: nil)
    end
  
    # GET /conversations/new
    def new
      @conversation = Conversation.new
    end
  
    # GET /conversations/1/edit
    def edit
    end
  
    # POST /conversations
    def create
      @conversation = Conversation.new(conversation_params)
  
      if @conversation.save
        redirect_to conversations_path, notice: 'Conversation was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /conversations/1
    def update
      if @conversation.update(conversation_params)
        redirect_to conversations_path, notice: 'Conversation was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /conversations/1
    def destroy
      @conversation.destroy
      redirect_to listings_path
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_conversation
        @conversation = Conversation.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def conversation_params
        params.require(:listing_id, :participant_id)
      end
  end