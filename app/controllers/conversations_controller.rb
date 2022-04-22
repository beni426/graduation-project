class ConversationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @conversations = Conversation.all
  end

  def create
    if user_signed_in?
      @conversation = if Conversation.between(params[:sender_id], params[:receiver_id]).present?
                        Conversation.between(params[:sender_id], params[:receiver_id]).first
                      else
                        Conversation.create!(conversation_params)
                      end
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end
end
