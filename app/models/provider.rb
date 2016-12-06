class Provider < ApplicationRecord

	#has_and_belongs_to_many :oportunities

	def self.send_email
		OportunityMailer.test("sdanielsilvas@gmail.com").deliver
	end
end
