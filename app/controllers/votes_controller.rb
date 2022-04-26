class VotesController < ApplicationController
  def create
      vote = current_user.votes.create(post_id: params[:post_id])
      redirect_to votes_path, notice: '投票をしました！'
  end
end