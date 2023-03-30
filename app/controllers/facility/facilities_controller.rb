class Facility::FacilitiesController < ApplicationController
  def show
    @facility = Facility.find(params[:id])
    
  end

  def index
  end
end
