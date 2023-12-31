class LikesController < ApplicationController
  def create
    @post = Post.includes(:likes).find(params[:post_id])
    @like = @post.likes.create(user_id: current_user.id)

    redirect_to user_post_path(@post.author, @post)
  end
end
