class LikesController < ApplicationController
    before_action :set_post, only: [:create, :destroy]
  
    def create
      @like = current_user.likes.build(post: @post)
      if @like.save
        respond_to do |format|
          format.html { redirect_to @post, notice: 'Liked!' }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to @post, alert: 'Unable to like.' }
          format.js { render :create_error }
        end
      end
    end
  
    def destroy
      @like = current_user.likes.find_by(post: @post)
      if @like.destroy
        respond_to do |format|
          format.html { redirect_to @post, notice: 'Unliked.' }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to @post, alert: 'Unable to unlike.' }
          format.js { render :destroy_error }
        end
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  end  
