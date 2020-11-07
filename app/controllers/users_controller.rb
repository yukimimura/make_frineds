class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @japanese = User.where(language: 'japanese')
    @english = User.where(language: 'english')
  end

  def show 
    @user = User.find(params[:id])
  end
end
