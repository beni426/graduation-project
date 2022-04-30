# frozen_string_literal: true

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
    @array_data = []
    count = 0
    @hash_data = @user.posts.map { |post| { name: post.title, data: post.votes.count } }
    @hash_data.each_with_index do |_k, i|
      hash_graph = {}
      hash_graph[:name] = @post.map(&:title)[i]
      hash_graph[:data] = @hash_data[i]
      @array_data[i] = hash_graph
      count = i
    end
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
