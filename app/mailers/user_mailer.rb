class UserMailer < ApplicationMailer
  if Church.count > 0 
    default from: Church.first.email
  else
    default from: "notify@lolconcepts.com"
  end

  def new_pr
    @users = User.all.where(:sms_ok => true,:disabled => false).where.not(telephone: [nil,""],carrier_id: [nil]).where(:admin => true)
    @email_list = []
    @users.each do |s|
      email = s.smsAddress
      if email != ""
        @email_list << email
      end
    end
    @email_list = @email_list.uniq
    @subj = "CTPO-Notice"
    mail(:bcc => @email_list, :subject => @subj, :body => "new prayer request")
  end

  def new_gift
    @users = User.all.where(:sms_ok => true,:disabled => false).where.not(telephone: [nil,""],carrier_id: [nil]).where(:finance => true)
    @email_list = []
    @users.each do |s|
      email = s.smsAddress
      if email != ""
        @email_list << email
      end
    end
    @email_list = @email_list.uniq
    @subj = "CTPO-Notice"
    mail(:bcc => @email_list, :subject => @subj, :body => "new offering received")
  end

  def alert(d)
    @attended_service = []
    @attendance_for_day = Checkin.all.where('short_date' => d)
    @attendance_for_day.each do |a|
      @attended_service << a.user
    end
    @users = @attended_service
    @email_list = []
    @users.each do |s|
      email = s.smsAddress
      if email != ""
        @email_list << email
      end
      if s.email != ""
        @email_list << s.email
      end
    end
    @email_list = @email_list.uniq
    @subj = "ALERT"
    message = "Please contact the church at #{Church.first.telephone}"
    mail(:bcc => @email_list, :subject => @subj, :body => message)
  end
  
  # Send out a note to ALL students. Template:=> /views/user_mailer/email_blast.text.erb
  def email_blast(subject,message)
    @users = User.all.where(:sms_ok => true,:disabled => false).where.not(telephone: [nil,""],carrier_id: [nil])
    @email_list = []
    @users.each do |s|
      email = s.smsAddress
      if email != ""
        @email_list << email
      end
    end
    @email_list = @email_list.uniq
    @subj = subject
    mail(:bcc => @email_list, :subject => @subj, :body => message)
  end

  def mediarelease_email_blast(subject,message)
    @users = User.all.where(:sms_ok => true,:disabled => false,:mediarelease => false).where.not(telephone: [nil,""],carrier_id: [nil])
    @email_list = []
    @users.each do |s|
      email = s.smsAddress
      if email != ""
        @email_list << email
      end
    end
    @email_list = @email_list.uniq
    @subj = subject
    mail(:bcc => @email_list, :subject => @subj, :body => message)
  end

  
  def missingCheckin(user)
    @user = User.find(user.to_i)
    @email_list = []
    @lastCheckin = @user.lastSeen
    @church_telephone = Church.first.telephone
    @pastor = Church.first.pastor
    @subj = "We Miss You!"
    
      #email = s.smsAddress
      #if email != ""
       # @email_list << email
      #end
      @email_list << @user.email
      @subj = "We Miss You, #{@user.fullname}"
    
    @email_list = @email_list.uniq
    message = "We just wanted to drop a quick note to check up on you."
    message += " We last saw you #{@lastCheckin} ago. Please reach out to the church "
    message += " at #{@church_telephone} to let us know you are ok."
    message += "--#{@pastor}"
    mail(:bcc => @email_list, :subject => @subj, :body => message)
  end

  def PrayerChainEmail
    @email_list = []
    @church = Church.first
    @subj = "#{@church.name} Prayer Chain"
    @requests = Request.all
    @email_list << @church.prayer_chain
    
    
    @email_list = @email_list.uniq
    message = "Please pray for"
    @requests.each do |r|
      message += " #{r.pretty} </br>"
    end
    mail(:bcc => @email_list, :subject => @subj)#, :body => message)
  end

  def gift_thanks(user,amount,offering)
    @users = User.where(:disabled => false).where.not(telephone: [nil,""],carrier_id: [nil]).where(id: user.to_i)
    @offering = Offering.find(offering)
    @offering.acknowledge = true
    @offering.save
    @email_list = []
    @church = Church.first
    @amount = amount
    @subj = "Thank You For Your #{amount} Gift"
    @users.each do |s|
      #email = s.smsAddress
      #if email != ""
       # @email_list << email
      #end
      @email_list << s.email
      @subj = "Thank You!, #{s.fullname}"
    end
    @email_list = @email_list.uniq
    message = " You gave #{amount}! "
    message += @church.thankyou
    message += "- #{@church.name}"
    mail(:bcc => @email_list, :subject => @subj, :body => message)
  end

end