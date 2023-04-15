class Facility::MessagesController < ApplicationController
  
  def create
    @message = current_facility.messages.new(message_params)
    @message.save
    @room = @message.room
    @messages = @room.messages
    # render :validater unless @message.save
  end
  
  private
  
  def message_params
    params.require(:message).permit(:body, :room_id, :reader_id)
  end
end
