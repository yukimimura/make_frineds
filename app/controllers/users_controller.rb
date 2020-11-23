class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @japanese = User.where(language: 'Japanese')
    @english = User.where(language: 'English').order(current_sign_in_at: "DESC")
  end

  def show 
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    @likes = @user.myfavorites

    # DM機能
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :image, :age, :intro)
  end
end
