class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #:confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #,:confirmable, :lockable, :timeoutable, :trackable


   mount_uploader :avatar, AvatarUploader

   profanity_filter :fname, :lname, :address, :address2, :city, :state, :zip, :method => 'stars'

   has_one :pronoun

   def fullname
   	if self.fname && self.lname
   		return self.fname + " " + self.lname
   	else
   		return ""
   	end
   end

   def makeAdmin
    self.admin = true
    self.save
   end
   def makeFinance
    self.finance = true
    self.save
   end

   def custom
     if self.custom_gift != nil
      return self.custom_gift + "00"
     else
      return "0"
     end
   end
   
   def gifts
    @offeringsToday = 0
    @gifts = Offering.all.where(created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_day,uid: self.id)
    @gifts.each do | g|
      @offeringsToday += g.amount.to_f/100
    end
    return @offeringsToday
   end

   def smsAddress
    if self.carrier_id && self.telephone
      @sms = "#{self.telephone.tr('-','')}#{Carrier.find(self.carrier_id).suffix}"
    else
      @sms = ""
    end
    return @sms
  end
end
