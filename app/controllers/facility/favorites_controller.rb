class Facility::FavoritesController < ApplicationController
  
  def index
    @reader = Reader.find_by(params[:reader_id])
    @favorites = Favorite.where(reader_id: @reader.id).uniq
  end
  
end
