class Facility::FacilitiesController < ApplicationController
  before_action :authenticate_facility!
  before_action :is_matching_login_facility, only: [:edit, :update, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found # 存在しないIDを直打ちしたときの制限

  def show
    @facility = Facility.find(params[:id])
  end

  def edit
    @facility = Facility.find(params[:id])
  end

  def update
    @facility = Facility.find(params[:id])
    if @facility.update(facility_params)
      flash[:notice] = '編集しました'
      redirect_to facility_facility_path(@facility)
    else
      render 'edit'
    end
  end
  
  def destroy
    @facility = Facility.find(params[:id]) 
    @facility.destroy
    flash[:alert] = '退会しました。再度ご利用の場合は、新規登録をお願い致します。'
    redirect_to :root #削除に成功すればrootページに戻る
  end

  # def unsubscribe
  # end

  # def withdraw
  #   @facility = current_facility
  #   @facility.update(is_deleted: true)
  #   reset_session
  #   flash[:notice] = "退会処理を実行いたしました"
  #   redirect_to root_path
  # end

  private

  def facility_params
    params.require(:facility).permit(:first_name, :last_name, :facility_name, :user_facility_name, :introduct, :facility_intro, :address, :telephone, :profile_image)
  end
  
  def is_matching_login_facility
    facility = Facility.find(params[:id])
    unless facility.id == current_facility.id
      redirect_to root_path
    end
  end
  
   # 存在しないIDに直打ちしたときの表記
  def record_not_found
    render plain: "404 Not Found", status: 404
  end
end
