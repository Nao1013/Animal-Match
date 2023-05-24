class Facility::FavoritesController < ApplicationController
  before_action :authenticate_facility!
  before_action :check_favorite, only: [:index]

  def index
    @animal = Animal.find(params[:animal_id])
    # アソシエーションを用いて左辺の@animalに紐づいたfavoriteをすべて取得している
    @favorites = @animal.favorites
    @facility = current_facility
  end

  private

  def check_favorite
    favorite = Favorite.find_by(animal_id: params[:animal_id])
    # もし、いいねがされておらず、あるいは、いいねはされていてもcurrent_facilityじゃない場合はルートへ飛ぶ
    if !favorite.present? || (favorite.present? && favorite.animal.facility.id != current_facility.id)
      redirect_to root_path
    end
  end

end
