class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      customer_root_path
    end
  end
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      root_path
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    
      if resource_or_scope == :admin_admin
        new_admin_admin_session_path
      else
        new_customer_session_path
      end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana,
      :last_name_kana, :postcode, :address, :phone_number, :is_deleated])
  end  

end

