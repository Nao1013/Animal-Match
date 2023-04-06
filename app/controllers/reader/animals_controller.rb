class Reader::AnimalsController < ApplicationController
  def index
    @genres = Genre.all
    @animals = Tag.search(params[:tag])
    @animals = params[:name].present? ? Genre.find(params[:name]).animals : Animal.all
  end

  def show
    @animal = Animal.find(params[:id])
    @tags = @animal.tags.pluck(:tag)
    @facility = Facility.find(params[:id])
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, images: [], genre_ids: [])
  end
end
