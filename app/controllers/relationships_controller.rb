class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:notice] = 'You followed the user.'
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:alert] = 'You unfollowed the user.'
    redirect_to user
  end
end
