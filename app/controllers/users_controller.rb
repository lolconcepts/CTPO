class UsersController < ApplicationController
	def destroy
		u = User.find(params[:id])
		u.destroy
		respond_to do |format|
      		format.html { redirect_to '/all_users', notice: "User #{u.email} has been deleted." }
      		format.json { head :no_content }
    	end
	end
	def impersonate
    	user = User.find(params[:id])
    	impersonate_user(user)
    	redirect_to root_path
  	end

  	def stop_impersonating
    	stop_impersonating_user
    	redirect_to root_path
  	end
end