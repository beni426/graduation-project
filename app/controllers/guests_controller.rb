class GuestsController < ApplicationController
  def new_guest
    user = User.find_or_create_by!(name: 'guset1', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def new_admin_guest
    user = User.find_or_create_by!(name: 'admin-guest', email: 'guestadmin@example.com', admin: true) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲスト管理者ユーザーとしてログインしました。'
  end
end
