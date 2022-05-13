# frozen_string_literal: true

class Conversation < ActiveRecord::Base
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :receiver, foreign_key: :receiver_id, class_name: 'User'
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :sender_id, scope: :receiver_id
  has_many :notifications, dependent: :destroy

  scope :between, lambda { |sender_id, receiver_id|
    where('(conversations.sender_id = ? AND conversations.receiver_id =?) OR (conversations.sender_id = ? AND  conversations.receiver_id =?)', sender_id, receiver_id, receiver_id, sender_id)
  }

  def target_user(current_user)
    if sender_id == current_user.id
      User.find(receiver_id)
    elsif receiver_id == current_user.id
      User.find(sender_id)
    end
  end

  def create_notification_dm!(current_user, conversation_id, message_id)
    dm_user = Conversation.select(:user_id).where(conversation_id: conversation_id).where.not(user_id: current_user.id).distinct
    dm_user.each do |dm_user|
      save_notification_dm!(current_user, message_id, dm_user['user_id'], conversation_id) 
    end
    if dm_user.blank?
      visited_id = Conversation.where(conversation_id: conversation_id).where.not(user_id: current_user.id).distinct.first.user_id
      save_notification_dm!(current_user, message_id, visited_id, conversation_id)
    end
  end
  def save_notification_dm!(current_user, message_id, visited_id, conversation_id)
    notification = current_user.active_notifications.new(
      conversation_id: conversation_id,
      message_id: message_id,
      visited_id: visited_id,
      action: 'dm',
      checked: false
    )
    notification.save! if notification.valid?
  end
end
