class Offering < ApplicationRecord
	def normalized_amount
		if self.amount.to_i < 100
			return "$#{self.amount.to_f/100}"
		else
			return "$#{self.amount.to_i/100}"
		end
		
	end
end
