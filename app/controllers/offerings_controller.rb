class OfferingsController < ApplicationController
	PER_PAGE = 10
	def index
		@church = Church.first
		@page = params.fetch(:page, 0).to_i #fetch allows a default param in the event that there isnt a param passed
		@offerings = Offering.all.where(created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_day).order(created_at: :desc).offset(@page * PER_PAGE).limit(PER_PAGE)
	end
	def new
	end
end
