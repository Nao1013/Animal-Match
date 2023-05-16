# frozen_string_literal: true

class Reader::SessionsController < Devise::SessionsController
  
  # before_action :configure_sign_in_params, only: [:create]
  
  def guest_sign_in
    reader = Reader.guest
    sign_in reader
    redirect_to reader_animals_path, notice: 'ゲストユーザーとしてログインしました。'
  end
 
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
  
  def reject_withdraw_reader
    @facility = Facility.find_by(email: params[:reader][:email].downcase)
    if @facility
    if (@facility.valid_password?(params[:reader][:password]) && (@reader.active_for_authentication? == false))
      flash[:notice] = "退会済みのためログインできません。"
      redirect_to new_reader_session_path
    end
    end
  end
end
