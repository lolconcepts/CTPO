module PagesHelper
	def user_count
		return User.count
	end
	def attendee_count
		return Checkin.where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week).count
	end
	
	def users_last_week
		user_count =  User.where("created_at < ?", Time.zone.now.beginning_of_week).count
	end
	
	def giving_last_week
		amount = 0
		offerings =  Offering.where(created_at: Time.zone.now.beginning_of_week - 7.days..Time.zone.now.end_of_week - 7.days)
		offerings.each do |o|
			amount += o.amount.to_i
		end
		return amount / 100
	end
	
	def attendance_last_week
		return Checkin.where(created_at: Time.zone.now.beginning_of_week - 7.days..Time.zone.now.end_of_week - 7.days).count
	end

	def difference(lastweek, thisweek)
		#initial or no change
		if lastweek == 0 && thisweek == 0
			return "0"
		end
		# less with 0 for thisweek
		if thisweek == 0
			return "-100"
		end
		# more with 0 for lastweek
		if lastweek == 0
			return "100"
		end
		return ((thisweek.to_f / lastweek.to_f) * 100) - 100
	end
end
