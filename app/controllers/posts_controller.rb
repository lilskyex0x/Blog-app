class PostsController < ApplicationController
  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.where.not(id: nil).order(created_at: :asc)
    @new_post = @user.posts.build
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post was successfully created.'
    else
      flash[:alert] = @post.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
