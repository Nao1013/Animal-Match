class Reader::MessagesController < ApplicationController
  before_action :reject_non_related, only: [:show]
  
  def show
    @facility = Facility.find(params[:id]) #チャットする相手は誰か？
    rooms = current_reader.reader_rooms.pluck(:room_id) #ログイン中のユーザーの部屋情報を全て取得
    facility_rooms = Room.find_by(facility_id: @facility.id, room_id: rooms) #その中にチャットする相手とのルームがあるか確認

    unless facility_rooms.nil? #facilityルームがあった
      @room = reader_rooms.room #変数@roomにユーザー（自分と相手）と紐づいているroomを代入
    else #ユーザールームが無かった場合
      @room = Room.new #新しくRoomを作る
      @room.save #そして保存
      # Room.create(reader_id: current_reader.id, room_id: @room.id) #自分の中間テーブルを作る
      # Room.create(reader_id: @reader.id, room_id: @room.id) #相手の中間テーブルを作る
    end 
    @messages = @room.messages #チャットの一覧用の変数
    @message = Message.new(room_id: @room.id) #チャットの投稿用の変数
  end
  
  def create
    @message = current_reader.messages.new(message_params)
    render :validater unless @message.save
  end
  
  private
  def message_params
    params.require(:message).permit(:body, :room_id)
  end
  
end
