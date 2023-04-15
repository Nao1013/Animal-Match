class Reader::RoomsController < ApplicationController
  
  def create
    @facility = Facility.find(params[:facility_id])
    @room = Room.find_or_create_by(facility: @facility, reader: current_reader)
    redirect_to reader_room_path(@room)
  end
  
  def show
    @room = Room.find(params[:id])
    @facility = @room.facility
    @messages = @room.messages #チャットの一覧
    @message = Message.new #チャットの投稿
  end
end
