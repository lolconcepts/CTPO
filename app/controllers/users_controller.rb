class UsersController < ApplicationController
  #before_action :set_user, only: [:edit, :update]
  def destroy
		u = User.find(params[:id])
		u.destroy
		respond_to do |format|
      		format.html { redirect_to '/all_users', notice: "User #{u.email} has been deleted." }
      		format.json { head :no_content }
    end
	end
  def edit
    @church = Church.first
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:user][:id])
      if @user.update(user_params)
        redirect_to '/parishioners', notice: 'User was successfully updated.' 
      else
        
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
    def index
      @church = Church.first
      if params[:search].blank?  
        redirect_to(parishioners_path, alert: "Empty field!") and return  
      else 
        @user = User.first
      end
    end
    def import
      if User.import(params[:file])
        redirect_to root_url, notice: "User Data Imported"
      else
        edirect_to root_url, notice: "Error Occured"
      end

    end
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:id,:fname, :lname, :address, :address2, :city, :state, :zip, :carrier_id, :avatar, :telephone,:sms_ok, :role, :skill,:stripe_id,:pronoun_id,:custom_gift, :cover, :calendly_url, :acknowledge, :target, :spouse, :professing_member, :how_heard, :children,:end_of_year_report)
    end
end