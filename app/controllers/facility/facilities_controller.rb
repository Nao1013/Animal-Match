class Facility::FacilitiesController < ApplicationController
  before_action :authenticate_facility!

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
  
  def unsubscribe
  end
  
  def withdraw
    @facility = current_facility
    @facility.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def facility_params
    params.require(:facility).permit(:first_name, :last_name, :facility_name, :user_facility_name, :introduct, :facility_intro, :address, :telephone, :profile_image)
  end
end
