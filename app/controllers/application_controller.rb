class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :contact_number, :role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :contact_number, :role])
    end

    def after_sign_in_path_for(resource)
      if resource && resource.role == 'farmer'
        farmer_path
      elsif resource && resource.role == 'buyer'
        buyer_path
      elsif resource && resource.role == 'admin'
        admin_path
      else
        root_path
      end
    end
    
    
end
