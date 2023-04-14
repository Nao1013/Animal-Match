class Facility::RoomsController < ApplicationController
  def index
   @messages = room.messages.order(created_at: :desc).first(5)
  end
  
  def show
    @message = Message.new
    @messages = Message.where(room_id: @room.id)
  end
end
