class ApplicationController < ActionController::Base
	 before_action :configure_permitted_parameters, if: :devise_controller?
	 impersonates :user
	 @version = '21.05'
 protected

 def configure_permitted_parameters
 	attributes = [:fname, :lname, :address, :address2, :city, :state, :zip, :carrier_id, :avatar, :telephone,:sms_ok, :role, :skill,:stripe_id,:pronoun_id,:custom_gift, :cover, :calendly_url, :acknowledge, :target, :spouse, :professing_member, :how_heard, :children,:end_of_year_report,:giving_override,:yt]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
 end

 def checkin
 	if current_user
 		Checkin.new(:user => current_user)
 	end
 end


 def get_checkins
 	return Checkin.all.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
 end

 def after_sign_in_path_for(resource)
 	if User.count == 1
 		#Make Admin
 		current_user.admin = true
 		current_user.finance = true
 		current_user.save
 	end
    if current_user.fullname == "" 
    	edit_user_registration_url
    else
    	root_path
    end
 end
end

