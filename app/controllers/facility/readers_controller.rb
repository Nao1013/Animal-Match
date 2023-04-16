class Facility::ReadersController < ApplicationController
  
  def show
    @reader = Reader.find(params[:id])
  end
  
end
