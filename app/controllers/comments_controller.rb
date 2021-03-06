# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[create edit update]
  before_action :set_comment, only: %i[edit update destroy]
  before_action :author_required, only: %i[edit update destroy]
  
  def create
    @comment = current_user.comments.build(comment_params.merge(post_id: @post.id))
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to post_path(@post), notice: 'コメントできませんでした...' }
      end
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = 'コメントが編集されました'
        format.js { render :index }
      else
        flash.now[:notice] = 'コメントの編集に失敗しました'
        format.js { render :edit }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントを削除しました'
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def author_required
    set_comment
    unless current_user == @comment.user
      flash[:danger] = I18n.t("views.post.edit")
      redirect_back fallback_location: posts_path
    end
  end
end
