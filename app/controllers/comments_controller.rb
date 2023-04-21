class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post = @user.posts.find(params['post_id'])
    if @comment.save
      redirect_to user_posts_path(@user), notice: 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      @comment.update_post_comments_counter(@comment)
      redirect_to @post, notice: 'Comment was successfully destroyed.'
    else
      redirect_to @post, alert: 'Failed to destroy comment.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
