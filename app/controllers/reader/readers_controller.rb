class Reader::ReadersController < ApplicationController
  before_action :set_reader, only: [:favorites]
  
  def edit
    @reader = Reader.find(params[:id])
  end

  def show
    @reader = current_reader
  end

  def update
    @reader = Reader.find(params[:id])
    if @reader.update(reader_params)
      redirect_to reader_reader_path(@reader)
    else
      render 'edit'
    end
  end
  
  def favorites
    favorites = Favorite.where(reader_id: @reader.id).pluck(:animal_id)
    @favorite_animals = Animal.find(favorites)
  end

  private

  def reader_params
    params.require(:reader).permit(:first_name, :last_name, :user_name, :introduct, :prefecture, :profile_image)
  end
  
  def set_reader
    @reader = Reader.find(params[:id])
  end
end
