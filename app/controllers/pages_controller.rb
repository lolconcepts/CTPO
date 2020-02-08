class PagesController < ApplicationController
  def home
  	@church = Church.first
    @church_count = Church.count
    @events = Event.all.where('estart >= ?', DateTime.now)
    @requests = Request.count
    @offeringsToday = 0
    @stripe_fees = 0
    @dailyOfferings = Offering.all.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @dailyOfferings.each do |offering|
      @offeringsToday += offering.amount.to_f/100
      @stripe_fees += ((offering.amount.to_f * 0.029/100) + 0.30).round(2)
    end

  end
  def nametag
  	@user = User.find(params[:uid])
  	@church = Church.first
    @pronouns = Pronoun.find(@user.pronoun_id).description
    if @pronouns == "Prefer Not To Use" || @pronouns == "Prefer Not To Choose"
      @pronouns = ""
    else
      @pronouns = "pronouns: " + @pronouns
    end
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
  def financify
    @user = User.find(params[:id])
    @user.makeFinance 
    flash[:notice] = "#{@user.fullname} has been granted Finance Team Rights."
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
      :uid => params[:id] || 9999,
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
  def offeringcard
    @church = Church.first
  end
  def sucard
    @church = Church.first
  end

end
