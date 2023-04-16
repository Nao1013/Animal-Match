class Facility::FavoritesController < ApplicationController
  
  def index
    @animal = Animal.find(params[:animal_id])
    # アソシエーションを用いて左辺の@animalに紐づいたfavoriteをすべて取得している
    @favorites = @animal.favorites
  end
  
end
