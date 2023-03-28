class ApplicationController < ActionController::Base
  
 before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    # when Customer
      # root_path
    when facility
      admin_orders_path
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      new_customer_session_path
    end
  end
  
end
