class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = Message.where(id: @messages[-10..-1].pluck(:id))
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    @messages.where.not(user_id: current_user.id).update_all(read: true) if @messages.last
    @messages = @messages.order(:created_at)
    @message = @conversation.messages.build
  end
  # def create
  #       @message = @conversation.messages.build(message_params)
  #      @conversation= @message.conversation
  #     if @message.save
  #       other_room = Conversation.where(conversation_id: @conversation.id).where.not(user_id: current_user.id)
  #       theid= other_room.find_by(conversation_id: @conversation.id)
  #       notification = current_user.active_notifications.new(
  #          conversation_id: @conversation.id,
  #          message_id: @message.id,
  #          visited_id: @theid.user_id,
  #          visitor_id: current_user.id,
  #          action: 'dm'
  #       )
  #     if notification.visitor_id == notification.visited_id
  #         notification.checked = true
  #     end
  #       notification.save if notification.valid?
  #     redirect_to conversation_messages_path(@conversation)
  #   else

  #     render 'index'
  #   end
  # end
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
