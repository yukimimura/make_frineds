class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def index 
    @post = current_user.posts.build 
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Posted successfully.'
      redirect_back(fallback_location: root_path)
    else
      @posts = Post.all
      flash.now[:alert] = 'Failed to post.'
      render :index
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Deleted post.'
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
