class UserMailer < ApplicationMailer
  default from: Church.first.email || "notify@lolconcepts.com"
  
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

end