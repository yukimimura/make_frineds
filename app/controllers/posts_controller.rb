class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def index 
    @post = current_user.posts.build 
    # @post = Post.new でもOK
    @posts = Post.includes(:user).order(id: :desc)
  end

  def followings
    @post = current_user.posts.build 
    @posts = Post.where(user_id: current_user.following_ids + [current_user.id]).order(id: :desc)
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
    @comments = @post.comments.order(id: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @post = Post.includes(:user).order(id: "DESC")
      redirect_back(fallback_location: root_path)
    else
      @posts = Post.includes(:user).order(id: "DESC")
      render :index
    end
  end

  def destroy
    @post.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
