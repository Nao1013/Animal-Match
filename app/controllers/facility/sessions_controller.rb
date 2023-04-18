# frozen_string_literal: true

class Facility::SessionsController < Devise::SessionsController
  # before_action :reject_withdraw_facility, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]
  
  def guest_sign_in
    facility = Facility.guest
    sign_in facility
    redirect_to facility_animals_path, notice: 'guestuserでログインしました。'
  end
  
  # def logout
  #   reset_session
  #   response.headers['Cache-Control'] = 'no-store' # ブラウザのキャッシュを無効化する
  #   redirect_to root_path # ログアウト後にトップページに遷移する
  # end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  # def reject_withdraw_facility
  #   @facility = Facility.find_by(email: params[:facility][:email].downcase)
  #   if @facility
  #   if (@facility.valid_password?(params[:facility][:password]) && @facility.is_deleted)
  #     flash[:notice] = "退会済みのためログインできません。"
  #     redirect_to new_facility_session_path
  #   end
  #   end
  # end
end
