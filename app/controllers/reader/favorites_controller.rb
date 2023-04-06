class Reader::FavoritesController < ApplicationController
  
  def create
    animal = Animal.find(params[:animal_id])
    favorite = current_reader.favorites.new(animal_id: animal.id)
    favorite.save
    redirect_to reader_animal_path(animal)
  end
  
  def destroy
    animal = Animal.find(params[:animal_id])
    favorite = current_reader.favorites.find_by(animal_id: animal.id)
    favorite.destroy
    redirect_to reader_animal_path(animal)
  end
  
end
