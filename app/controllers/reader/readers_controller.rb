class Reader::ReadersController < ApplicationController
  before_action :set_reader, only: [:favorites]
  before_action :authenticate_reader!
  before_action :is_matching_login_reader, only: [:edit, :update, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found # 存在しないIDを直打ちしたときの制限

  def edit
    @reader = Reader.find(params[:id])
  end

  def show
    @reader = current_reader
  end

  def update
    @reader = Reader.find(params[:id])
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
    @reader = Reader.find(params[:id])
    @reader.destroy
    flash[:alert] = '退会しました。'
    redirect_to :root #削除に成功すればrootページに戻る
  end

  private

  def reader_params
    params.require(:reader).permit(:first_name, :last_name, :user_name, :introduct, :prefecture, :profile_image)
  end

  def set_reader
    @reader = Reader.find(params[:id])
  end

  def is_matching_login_reader
    reader = Reader.find(params[:id])
    unless reader.id == current_reader.id
      redirect_to root_path
    end
  end

  # 存在しないIDに直打ちしたときの表記
  def record_not_found
    render plain: "404 Not Found", status: 404
  end
end
