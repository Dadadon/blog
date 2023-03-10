class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      @comment.update_post_comments_counter(@comment)
      redirect_to @post, notice: 'Comment was successfully created.'
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
