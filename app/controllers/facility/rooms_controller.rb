class Facility::RoomsController < ApplicationController

  def create
   @reader = Reader.find(params[:reader_id])
   @room = Room.find_by(reader: @reader, facility: current_facility)
   redirect_to facility_room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @reader = @room.reader
    @messages= @room.messages # チャット一覧
    @message = Message.new # チャット投稿
  end

  def index
    @rooms = current_facility.rooms
    # readersはReaderに紐づいているMessageがログインしているfacilityへのメッセージの場合、そのreader_id(reader.id)を表示する、
    @readers = Reader.find(Message.where(facility_id: current_facility.id).pluck(:reader_id).uniq)
  end
end
