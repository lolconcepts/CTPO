class PagesController < ApplicationController
  def home
  	@church = Church.first
  end
  def nametag
  	@user = User.find(params[:uid])
  	@church = Church.first
  end
  def nametags
    @users = User.all
  end

  def offering
  	@amount = params[:amount] || "0"
  	@cover = params[:cover] || false
  end
  def all_users
    @users = User.all
  end

end
