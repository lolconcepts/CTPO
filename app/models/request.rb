class Request < ApplicationRecord
	def pretty
		return "#{self.who} (#{self.reason})"
	end
end
