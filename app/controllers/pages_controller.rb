class PagesController < ApplicationController
  def home
  	@church = Church.first
  end
  def nametag
  	@user = current_user || User.find(:params[:uid])
  	@church = Church.first
  end
  def offering
  	@amount = params[:amount] || "0"
  	@cover = params[:cover] || false

  end
end
