# frozen_string_literal: true

module NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @message = nil
    #notification.actionがfollowか、favoriteか、commentか、dmか
    case notification.action
      when "dm" then
        @message = Message.find_by(id: notification.message_id)&.message
        tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたに"+tag.a('メッセージ',href:message_path(notification.visiter), style:"font-weight: bold;")+"を送りました"
    end
  end
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
