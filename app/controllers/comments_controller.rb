class CommentsController < ApplicationController
  def create
    @post = Post.includes(comments: :user).find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
