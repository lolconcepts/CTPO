class PagesController < ApplicationController
  def home
  	@church = Church.first
    @church_count = Church.count
    @events = Event.all.where("'when' >= ?", DateTime.now)
    @requests = Request.count
  end
  def nametag
  	@user = User.find(params[:uid])
  	@church = Church.first
  end
  def nametags
    @users = User.all
  end

  def adminify
    @user = User.find(params[:id])
    @user.makeAdmin 
    flash[:notice] = "#{@user.fullname} has been granted Admin Rights."
    redirect_to all_users_url
  end

  def offering
  	@amount = params[:amount] || "0"
  	@cover = params[:cover] || 0
    @church = Church.first
    if @cover == 1
     @offering = calc_cover(@amount)
    else
      @offering = @amount
    end
  end
  def all_users
    @users = User.all
  end
  def calc_cover(amount)
    cash = amount.to_f
    cash = (cash * 0.029 + 0.30)
    return cash.to_s + "00"
  end
  def charge
    # Amount in cents
    @church = Church.first
    @amount = params[:amount]
    @amount = @amount.to_i
    @user = User.find(params[:id]) || User.first
    @description = "Offering - #{@church.name}"
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: @description,
      currency: 'usd',
    })

    offering = Offering.create({
      :stripe_id => params[:stripe_id],
      :uid => params[:id] || 999,
      :amount => @amount
    })
    flash[:notice] = "Thank you for your generous gift of $#{@amount/100}"
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  def test
  end

end
