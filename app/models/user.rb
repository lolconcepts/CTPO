class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #:confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #,:confirmable, :lockable, :timeoutable, :trackable

   mount_uploader :avatar, AvatarUploader

   profanity_filter :fname, :lname, :address, :address2, :city, :state, :zip, :method => 'stars'

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

   def smsAddress
    if self.carrier_id && self.telephone
      @sms = "#{self.telephone.tr('-','')}#{Carrier.find(self.carrier_id).suffix}"
    else
      @sms = ""
    end
    return @sms
  end
end
