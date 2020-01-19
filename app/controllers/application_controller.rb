class ApplicationController < ActionController::Base
	 before_action :configure_permitted_parameters, if: :devise_controller?

 protected

 def configure_permitted_parameters
 	attributes = [:fname, :lname, :address, :address2, :city, :state, :zip, :carrier_id, :avatar, :telephone,:sms_ok, :role]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
 end

 def after_sign_in_path_for(resource)
    if current_user.fullname == ""
    	edit_user_registration_url
    else
    	root_path
    end
 end
end

