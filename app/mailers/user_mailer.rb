class UserMailer < ApplicationMailer
  default from: "notify@lolconcepts.com"
  
  # Send out a note to students, when they miss a certain amount of classes. Template:=> /views/user_mailer/we_miss_you.text.erb
  def we_miss_you(student)
  @attendance_records = Attendance.where(:student_id => student.id)
  @last_seen = @attendance_records.last.created_at.strftime("%A,%B %y")
  @dojo = Dojo.find(1)
  @student = student
  mail(:to => student.email, :subject => "#{@student.first_name}, We Miss You!")
  end
  
  # Send out a note to students, when it's their birthday. Template:=> /views/user_mailer/happy_birthday.text.erb
  def happy_birthday(student)
  @dojo = Dojo.find(1)
  @student = student
  mail(:to => student.email, :subject => "Happy Birthday, #{@student.first_name}!")
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

end