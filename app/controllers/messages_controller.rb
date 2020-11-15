class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
      @message = Message.create(message_params)
      # 投稿されたメッセージをチャット参加者に配信
      ActionCable.server.broadcast 'room_channel', message: @message.template
  end

  private
  def message_params
    params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id)
  end
end
