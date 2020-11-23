class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      @post = Post.find(params[:post_id])
      @comments = @post.comments
      render 'posts/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
