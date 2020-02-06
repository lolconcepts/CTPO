class Offering < ApplicationRecord
	def normalized_amount
		return "$#{self.amount.to_i/100}"
	end
end
