require 'action_view'
require 'action_view/helpers'
require 'csv'
include ActionView::Helpers::DateHelper
class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  #:confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #,:confirmable, :lockable, :timeoutable, :trackable


   mount_uploader :avatar, AvatarUploader

   profanity_filter :fname, :lname, :address, :address2, :city, :state, :zip, :method => 'stars'

   has_one :pronoun
   has_many :checkins, :dependent => :destroy
   def fullname
   	if self.fname && self.lname
   		return self.fname + " " + self.lname
   	else
   		return ""
   	end
   end
   def status
    if(self.isMissing || self.stopped_giving)
      return "Warning"
    else
      return "Active"
    end
   end
   def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      User.create! row.to_hash
    end
  end
   def pronouns
      if self.pronoun_id
        return "(#{Pronoun.find(self.pronoun_id).description})"
      else
        return ""
      end
   end
   def lastSeen
    @checkins = Checkin.where(user: self)
    if @checkins.empty?
      return "Never Checked In"
    else
        return time_ago_in_words(@checkins.last.created_at)
    end
   end
   def lastGift
    @offerings = self.offerings
    if @offerings.empty?
      return "Never Gave Online"
    else
        return time_ago_in_words(@offerings.last.created_at)
    end
   end
   
   def self.to_csv
    attributes = %w(id fname lname address address2 city state zip telephone email role skill)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
   end
   
   def isMissing
    #get all checkins 
    @checkins = Checkin.where(user: self)
    #ensure that there is at least one
      if (@checkins.count > 0 && (@checkins.last.created_at < Date.today-15.days))# they have come to church via checkin
      #return true if the the last time they checked in was 
      #more that 15 days ago
        return true
      else
        return false
      end
   end

   def pretty_address
    return "#{self.address} #{self.city},#{self.state} #{self.zip}"
   end
   
   def pretty_phone
    
   end

   def toggleMediaRelease
    if self.mediarelease? #already released; remove release
      self.mediarelease = false
      self.save
    else
      self.mediarelease = true
      self.save
    end
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

    def get_cover(gift)
    cover = (gift.to_f * 0.0305) + 0.30
    cover = cover.round(2)
    cover = (cover * 100).to_i
    return cover/100.00
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

   def offerings
    return Offering.all.where(:uid => self.id)
   end
   def stopped_giving
    # Having Given Online
    if(self.gave && self.offerings.last.created_at < 2.weeks.ago )
    # No Giving in the last two weeks
      return true
    else
      return false
    end
   end
   def gave
    return self.offerings.count > 0
   end
end
