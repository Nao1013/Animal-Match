class Facility::FacilitiesController < ApplicationController
  before_action :authenticate_facility! # ログインしているfacility以外はアクセスできない（ブラウザバッグもできない）
  before_action :set_facility, only: [:show, :edit, :update, :destroy, :index] # IDが存在してるかどうかのみ探している
  before_action :is_matching_login_facility, only: [:edit, :update, :show] # @facilityとログインしているfacilityが同一なのか確認している

  def show
  end

  def edit
  end

  def update
    if @facility.update(facility_params)
      flash[:notice] = '編集しました'
      redirect_to facility_facility_path(@facility)
    else
      render 'edit'
    end
  end

  # def destroy
  #   @facility.destroy
  #   flash[:alert] = '退会しました。再度ご利用の場合は、新規登録をお願い致します。'
  #   redirect_to :root #削除に成功すればrootページに戻る
  # end

  def unsubscribe
    @facility = current_facility
  end

  def withdraw
    @facility = current_facility
    @facility.update(is_deleted: true)
    reset_session
    flash[:alert] = "退会しました。再度ご利用の場合は、新規登録をお願い致します。"
    redirect_to root_path
  end

  private

  def facility_params
    params.require(:facility).permit(:first_name, :last_name, :facility_name, :user_facility_name, :introduct, :facility_intro, :address, :address1, :address2, :telephone, :profile_image)
  end

  def is_matching_login_facility
    facility = Facility.find(params[:id])
    unless facility.id == current_facility.id
      redirect_to root_path
    end
  end

  def set_facility
    @facility = Facility.find_by(id: params[:id])
    redirect_to root_path unless @facility
  end
  
end
