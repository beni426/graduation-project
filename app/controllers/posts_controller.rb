class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update destroy]
  
  def index
    @posts = Post.all.includes(:user).status_public.order(created_at: :desc).page(params[:page]).per(10)
    @posts = @posts.all.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
  end

  def show
    @posts = Post.where(user_id: @post.user.id).order(created_at: :desc)
    @comments = @post.comments
    @comment = @post.comments.build
    @stock = current_user.stocks.find_by(post_id: @post.id) if user_signed_in?
    if @post.status_private? && @post.user != current_user
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'このページにはアクセスできません' }
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
   @post = current_user.posts.build(post_params)
    hash_label = {}
    params[:post][:label_ids].each do |label|
      hash_label[:label_ids] = label.split(",").flatten
    end
    @post.attributes = hash_label
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @post.save
          format.html { redirect_to posts_url, notice: '投稿をしました.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  def vote
    @posts = Post.all.includes(:user).status_public.order(created_at: :desc).page(params[:page]).per(10)
  end

  def vote_up
    @post = Post.find(params[:id])
    @post.votes.create
    redirect_to vote_path, notice: '投票をしました！'
  end

  def top; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: '投稿を更新しました！' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '投稿を削除しました！' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image, :image_cache, { label_ids: []}, :status)
  end
end
