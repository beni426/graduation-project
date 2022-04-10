class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  def mypage
    redirect_to user_path(current_user)
  end
  def show
    @post=@user.posts
    stocks = Stock.where(user_id: current_user.id).pluck(:post_id)
    @stock_list= Post.find(stocks)
  end
  def stocks
    @post=@user.posts
    stocks = Stock.where(user_id: current_user.id).pluck(:post_id)
    @stock_list= Post.find(stocks)
  end
  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end
  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
       params.fetch(:user, {}).permit(:name,:image,:image_cache)
  end
end
