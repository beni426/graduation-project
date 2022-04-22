class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[mypage edit update]
  before_action :set_user, only: %i[show edit update]
  
  def mypage
    redirect_to user_path(current_user)
  end

  def show
    @post = @user.posts
    stocks = Stock.where(user_id: current_user.id).pluck(:post_id)
    @stock_list = Post.find(stocks)
  end

  def stocks
    @post = @user.posts
    stocks = Stock.where(user_id: current_user.id).pluck(:post_id)
    @stock_list = Post.find(stocks)
  end

  def edit
     redirect_to user_path(@user) unless @user == current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_registration_path(current_user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :image, :image_cache)
  end
end
