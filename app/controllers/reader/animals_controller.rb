class Reader::AnimalsController < ApplicationController
 before_action :authenticate_reader! # ログインしているfacility以外はアクセスできない（ブラウザバッグもできない）
 
  def index
    # @facilities = Facility.find(params[:facility_name])
    @reader = current_reader
    @genres = Genre.all
    # if params[:name].present?
      @animals_cat = Genre.find_by(name: "猫").animals
      @animals_dog = Genre.find_by(name: "犬").animals
    # else
      @animals = Animal.all
    # end
    # @animals = @animals.where(facility_id: @facilities) # アニマルに紐ずいている現在登録されている施設側を表示させている
  end

  def show
    @animal = Animal.find(params[:id])
    @facility = Facility.find(@animal.facility_id)
    @comment = Comment.new
  end
  
  def search
    if params[:keyword].present?
      @animals = Animal.where('introduct LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, :image, genre_ids: [])
  end
  
  
end
