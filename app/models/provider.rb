class Provider < ApplicationRecord

	def self.send_email
		OportunityMailer.test("sdanielsilvas@gmail.com").deliver
	end
end
