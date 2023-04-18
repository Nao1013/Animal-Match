class Reader::AnimalsController < ApplicationController
 before_action :authenticate_reader! # ログインしているfacility以外はアクセスできない（ブラウザバッグもできない）
 
  
  def index
    # @facilities = Facility.find(params[:facility_name])
    @reader = current_reader
    @genres = Genre.all
    # @facilities = Facility.where(is_deleted: false).pluck('id') # 現在登録している施設側を絞り込んでいる
    # if params[:tag].present?
    #   @animals = Tag.search(params[:tag])
    if params[:name].present?
      @animals = Genre.find(params[:name]).animals
    else
      @animals = Animal.all
    end
    # @animals = @animals.where(facility_id: @facilities) # アニマルに紐ずいている現在登録されている施設側を表示させている
  end

  def show
    @animal = Animal.find(params[:id])
    # @tags = @animal.tags.pluck(:tag)
    @facility = Facility.find(@animal.facility_id)
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, :image, genre_ids: [])
  end
  
  
end
