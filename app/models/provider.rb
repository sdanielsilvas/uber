class Provider < ApplicationRecord

	#has_and_belongs_to_many :oportunities

	def self.send_email
		OportunityMailer.test("sdanielsilvas@gmail.com").deliver
	end

	def self.contact(opportunity,opportunityProvider)
		Oportunity.send_winner_email(opportunity)
	end

	def self.reject(opportunity,opportunityProvider)
		op = OportunityProvider.where(oportunity_identification:opportunity.identification)
		current  = op.where(id:opportunity.current_provider)
		current_position = current.first.position
		next_position = (current_position.to_i) +1
		new_current  = op.where(position:next_position)
		if new_current.empty?
			opportunity.status = "Rechazada"
			opportunity.save
		else
			opportunity.current_provider = new_current.first.id
			opportunity.save
			
			Oportunity.send_client_email(opportunity)
		end
	end
end
