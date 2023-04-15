class Reader::FacilitiesController < ApplicationController
  def show
    @facility = Facility.find(params[:id])
    @animals = Animal.where(facility_id: @facility)
  end
  
  private
  
  def facility_params
    params.require(:facility).permit(:first_name, :last_name, :facility_name, :user_facility_name, :introduct, :facility_intro, :address, :telephone, :profile_image)
  end
end
