class Request < ApplicationRecord
	def pretty
		return "#{self.who}"
	end
end
