class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
  end

  def update
    notification = Notification.find(params[:id])
    redirect_to action: :index if notification.update(checked: true)
  end
end
