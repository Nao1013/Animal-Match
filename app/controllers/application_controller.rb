class ApplicationController < ActionController::Base

 before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    # when Customer
      # root_path
    when Facility
      facility_animals_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :facility
      new_facility_session_path
    else
      new_reader_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:facility_name, :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :address, :telephone, :password])
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :password, :user_name, :prefecture])
  end

end
