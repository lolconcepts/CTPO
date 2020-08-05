class OfferingsController < ApplicationController
	def index
		@offerings = Offering.all.where(created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_day).order(created_at: :desc)
	end
	def new
	end
end
