class PagesController < ApplicationController
  PER_PAGE = 4
  def missing
    @church = Church.first
    @missing_members = []
    @users = User.all
    @users.each do |u|
      if u.isMissing
        @missing_members << u
      end
    end
  end
  def stopped
    @church = Church.first
    @stopped_giving = []
    @users = User.all
    @users.each do |u|
      if u.stopped_giving
        @stopped_giving << u
      end
    end
  end
  def home
    # version
    @version = '21.02.3'
    if ENV['ADMIN_TEST_USER']
       @demouser = ENV['ADMIN_TEST_USER']
       @demouserpass = ENV['ADMIN_TEST_USER_PASS']
       @democreds = "Admin Login:#{@demouser}/#{@demouserpass}"
       @demosite = true
     else
       @demosite = false
    end
    @missing_members = []
    @stopped_giving = []
    @users = User.all
    @users.each do |u|
      if u.isMissing
        @missing_members << u
      end
      if u.stopped_giving
        @stopped_giving << u
      end
    end
    #
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
    @church = Church.first
  	@user = User.find(params[:uid])
  	@church = Church.first
    if @user.pronoun_id == nil
      @pronouns = Pronoun.first.description
    else
      @pronouns = Pronoun.find(@user.pronoun_id).description
    end
    if @pronouns == "Prefer Not To Use" || @pronouns == "Prefer Not To Choose"
      @pronouns = ""
    else
      @pronouns = "pronouns: " + @pronouns
    end
  end
  def nametags
    @church = Church.first
    @users = User.all
  end

  def adminify
    @user = User.find(params[:id])
    if !@user.admin
      flash[:notice] = "#{@user.fullname} has been granted Admin Rights."
    else
      flash[:notice] = "#{@user.fullname} no longer has Admin Rights."
    end
    @user.makeAdmin 
    redirect_to all_users_url
  end

  def checkinEmail
    user = params[:uid]
    UserMailer.missingCheckin(user).deliver

    flash[:notice] = "A Checkin Note Has Been Sent to #{User.find(user.to_i).email}"
    redirect_to root_path
  end

  def PrayerChainEmail
    UserMailer.PrayerChainEmail.deliver

    flash[:notice] = "The Prayer List Chain Has Been Sent to #{Church.first.prayer_chain}"
    redirect_to root_path
  end

   def thankyouEmail
    user = params[:uid]
    amount = params[:amount]
    offering = params[:oid]
    UserMailer.gift_thanks(user,amount,offering).deliver

    flash[:notice] = "A Thank You Note Has Been Sent to #{User.find(user.to_i).email}"
    redirect_to root_path
  end
  
  def financify
    @user = User.find(params[:id])
    if !@user.finance
      flash[:notice] = "#{@user.fullname} has been granted Finance Team Rights."
    else
      flash[:notice] = "#{@user.fullname} no longer has Finance Team Rights."
    end
    @user.makeFinance 
    
    redirect_to all_users_url
  end

  def offering
    @church = Church.first
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
    @church = Church.first
    @page = params.fetch(:page, 0).to_i
    @users = User.all.offset(@page * PER_PAGE).limit(PER_PAGE)
    @userss = User.all
    respond_to do |format|
      format.html
      format.csv { send_data @userss.to_csv }
    end
  end
  def calc_cover(amount)
    cash = amount.to_f
    cash = (cash * 0.0305 + 0.30)
    return cash.to_s + "00"
  end
  def charge
    # Amount in cents
    @church = Church.first
    @amount = params[:amount]
    @amount = @amount.to_i
    @target = params[:target]
    if current_user
      @user = current_user.fullname
    else
      @user = "Guest"
    end
    

    @description = "Offering - #{@target} - #{@user}"
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
      :amount => @amount,
      :target => @target
    })
    UserMailer.new_gift.deliver #deliver message
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
