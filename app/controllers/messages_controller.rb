# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = Message.where(id: @messages[-10..].pluck(:id))
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    @messages.where.not(user_id: current_user.id).update_all(read: true) if @messages.last
    @messages = @messages.order(:created_at)
    @message = @conversation.messages.build
  end
  #  def create
  #   # @message = current_user.messages.new(message_params)
  #   @message = @conversation.messages.build(message_params)
  #   @conversation = @message.conversation
  #    if @message.save
  #     binding.pry
  #     @message.conversation.create_notification_dm!(current_user, @message.conversation_id, @message.id)
  #     @messages = @conversation.messages
  #     @message = message.new(conversation_id: message_params[:conversation_id])
  #     redirect_to conversation_messages_path(@conversation)
  #    else
  #     render 'index'
  #    end
  #  end
  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      render 'index'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id).merge(user_id: current_user.id)
  end
end
