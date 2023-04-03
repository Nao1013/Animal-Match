class Facility::FacilitiesController < ApplicationController

  def show
    @facility = Facility.find(params[:id])
  end

  def index
  end

  def edit
    @facility = Facility.find(params[:id])
  end

  def update
    @facility = Facility.find(params[:id])
    if @facility.update(facility_params)
      redirect_to facility_facility_path(@facility)
    else
      render 'edit'
    end
  end

  private

  def facility_params
    params.require(:facility).permit(:first_name, :last_name, :facility_name, :user_facility_name, :introduct, :facility_intro, :address, :telephone, :profile_image)
  end
end
