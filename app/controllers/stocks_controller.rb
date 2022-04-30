# frozen_string_literal: true

class StocksController < ApplicationController
  def create
    stock = current_user.stocks.create(post_id: params[:post_id])
    redirect_to posts_path, notice: "#{stock.post.user.name}さんの愚痴をストックしました"
  end

  def destroy
    stock = current_user.stocks.find_by(id: params[:id]).destroy
    redirect_to posts_path, notice: "#{stock.post.user.name}さんのブログの愚痴を解除しました"
  end
end
