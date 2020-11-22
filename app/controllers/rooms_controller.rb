class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @currentEntries = current_user.entries
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?',current_user.id)

    # トークの最新順に表示
    messageIds = []
    @anotherEntries.each do |e|
      room = Room.find(e.room.id)
      if room.messages.present?
        messageIds << room.messages.last.id
      end
    end
    @messages = Message.find(messageIds.sort.reverse)

    # DM機能
    @room = Room.new
    @entry = Entry.new
    
    @followings = current_user.followings
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @entry = @room.entries.where('user_id != ?',current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end
   
  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(rooms_params)
    redirect_to room_path(@room.id)
  end

  private
  def rooms_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end
