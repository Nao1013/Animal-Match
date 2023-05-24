class Reader::ReadersController < ApplicationController
  before_action :authenticate_reader! # ログインしているfacility以外はアクセスできない（ブラウザバッグもできない）
  before_action :set_reader, only: [:favorites, :show, :edit, :update, :favorites, :destroy] # IDが存在してるかどうかのみ探している
  before_action :is_matching_login_reader, only: [:edit, :update, :show, :favorites, :destroy] # @readerとログインしているreaderが同一なのか確認している
  

  def edit
  end

  def show
  end

  def update
    if @reader.update(reader_params)
      redirect_to reader_reader_path(@reader),notice:'編集しました'
    else
      render 'edit'
    end
  end

  def favorites
    favorites = Favorite.where(reader_id: @reader.id).pluck(:animal_id)
    @favorite_animals = Animal.find(favorites)
  end

  # def destroy
  #   @reader.destroy
  #   flash[:alert] = '退会しました。再度ご利用になりたい場合は新規登録をお願い致します。'
  #   redirect_to :root #削除に成功すればrootページに戻る
  # end

  def unsubscribe
    @reader = current_reader
  end

  def withdraw
    @reader = current_reader
    @reader.update(is_deleted: true)
    reset_session
    flash[:alert] = "退会しました。再度ご利用の場合は、新規登録をお願い致します。"
    redirect_to root_path
  end

  private

  def reader_params
    params.require(:reader).permit(:first_name, :last_name, :user_name, :introduct, :prefecture, :profile_image)
  end

  def set_reader
    @reader = Reader.find_by(id: params[:id])
    redirect_to root_path unless @reader
  end

  def is_matching_login_reader
    unless @reader == current_reader
      redirect_to root_path
    end
  end
  
  def check_active_reader
    redirect_to root_path unless @reader.active?
  end

end
