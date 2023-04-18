class Reader::ReadersController < ApplicationController
  before_action :authenticate_reader! # ログインしているfacility以外はアクセスできない（ブラウザバッグもできない）
  before_action :set_reader, only: [:favorites, :show, :edit, :update, :destroy] # IDが存在してるかどうかのみ探している
  before_action :is_matching_login_reader, only: [:edit, :update, :show, :destroy] # @readerとログインしているreaderが同一なのか確認している

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

  def destroy
    @reader.destroy
    flash[:alert] = '退会しました。'
    redirect_to :root #削除に成功すればrootページに戻る
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

end
