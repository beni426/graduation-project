class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc) 
    @posts = @posts.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
  end
  def show
    @posts = Post.where(user_id: @post.user.id).order(created_at: :desc)
    @comments = @post.comments
    @comment = @post.comments.build
    @post= @post.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    @stock = current_user.stocks.find_by(post_id: @post.id) if user_signed_in?
  end
  def new
    @post = Post.new
  end
  def edit
  end
  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else 
   respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: "Post was successfully created." }
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
    @posts = Post.all 
    @posts = @posts.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
  end
  def top
  end
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :image, :image_cache,:status,{ label_ids: [] })
    end
end
