# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = current_user.passive_notifications
  end

  def update
    notification = Notification.find(params[:id])
    redirect_to action: :index if notification.update(checked: true)
  end
  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
    redirect_back(fallback_location: root_path)
  end
end
