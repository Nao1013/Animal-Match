class Facility::FavoritesController < ApplicationController
  # before_action :authenticate_facility!
  # before_action :set_facility, only: [:index]
  # before_action :is_matching_login_facility, only: [:index]
  
  def index
    @animal = Animal.find(params[:animal_id])
    # アソシエーションを用いて左辺の@animalに紐づいたfavoriteをすべて取得している
    @favorites = @animal.favorites
  end
  
  # private
  
  # def set_facility
  #   @facility = Facility.find_by(id: params[:id])
  #   redirect_to root_path unless @facility
  # end
  
  # def is_matching_login_facility
  #   facility = Facility.find(params[:id])
  #   unless facility.id == current_facility.id
  #     redirect_to root_path
  #   end
  # end
  
end
