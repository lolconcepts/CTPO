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
   
   def pretty_address
    return "#{self.address} #{self.city},#{self.state} #{self.zip}"
   end

   def makeAdmin
    if self.admin #already and admin; remove admin
      self.admin = false
    else
      self.admin = true
    end
    self.save
   end
   def makeFinance
    if self.finance #already finance; remove finance
      self.finance = false
    else
      self.finance = true
    end
    self.save
   end

   def custom
    if self.custom_gift != nil && self.cover
      return calc_cover(self.custom_gift).to_s
    elsif self.custom_gift != nil && !self.cover
      return self.custom_gift + "00"
    else
      return "0"
    end
   end
   
   def calc_cover(gift)
    cover = (gift.to_f * 0.0305) + 0.30
    cover = cover.round(2)
    cover = (cover * 100).to_i
    gift = (gift +  "00").to_i
    return cover + gift
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
