class Reader::MessagesController < ApplicationController
  
  def create
    @message = current_reader.messages.new(message_params)
    @message.save
    @room = @message.room
    @messages = @room.messages
    # render :validater unless @message.save  
  end
  
  private
  
  def message_params
    params.require(:message).permit(:body, :room_id, :facility_id)
  end
end
