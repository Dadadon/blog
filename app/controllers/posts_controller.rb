class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, :comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = @current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def like
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to @post, notice: 'Post was successfully liked.'
    else
      redirect_to @post, alert: 'Unable to like post.'
    end
  end

  def unlike
    @like = @post.likes.find_by(user: current_user)

    if @like.destroy
      redirect_to @post, notice: 'Post was successfully unliked.'
    else
      redirect_to @post, alert: 'Unable to unlike post.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
