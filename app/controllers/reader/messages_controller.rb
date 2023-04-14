class Reader::MessagesController < ApplicationController
  
  def show
    @facility = Facility.find(params[:id]) #チャットする相手は誰？
    rooms = current_facility.facility_rooms.pluck(:room_id) #ログイン中のユーザーの部屋情報を全て取得
    facility_rooms = FacilityRoom.find_by(facility_id: @facility.id, room_id: rooms)#その中にチャットする相手とのルームがあるか確認

    unless facility_rooms.nil?#ユーザールームがある場合
      @room = facility_rooms.room#変数@roomにユーザー（自分と相手）と紐づいているroomを代入
    else#ユーザールームが無かった場合
      @room = Room.new#新しくRoomを作る
      @room.save#そして保存
      Room.create(reader_id: current_reader.id, room_id: @room.id)#自分の中間テーブルを作成
      Room.create(facility_id: @facility.id, room_id: @room.id)#相手の中間テーブルを作成
    end
    @messages = @room.messages#チャットの一覧
    @message = Message.new(room_id: @room.id)#チャットの投稿
  end
  
  def create
    @message = current_reader.chats.new(message_params)
    @room = @message.room
    @messages = @room.messages
    render :validater unless @message.save  
  end
  
  private
  
  def message_params
    params.require(:message).permit(:body, :room_id).merge(reader_id: current_reader.id)
  end
end
