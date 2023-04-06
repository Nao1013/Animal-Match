class Reader::AnimalsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:tag].present?
      @animals = Tag.search(params[:tag])
    elsif params[:name].present?
      @animals = Genre.find(params[:name]).animals
    else
      @animals = Animal.all
    end
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
