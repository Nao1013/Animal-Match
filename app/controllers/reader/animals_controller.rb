class Reader::AnimalsController < ApplicationController
  def index
    @genres = Genre.all
    @animals = params[:name].present? ? Genre.find(params[:name]).animals : Animal.all
  end

  def show
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, images: [], genre_ids: [])
  end
end
