class Provider < ApplicationRecord

	#has_and_belongs_to_many :oportunities

	def self.send_email
		OportunityMailer.test("sdanielsilvas@gmail.com").deliver
	end

	def self.contact(opportunity,opportunityProvider)
		Oportunity.send_winner_email(opportunity)
	end

	def self.choose(opportunity,opportunityProvider)
		OportunityMailer.choosed("ricardo.pineda@serviciosenweb.com",opportunity,opportunityProvider).deliver
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

	def self.createProviders(prov,oportunity)
		providers = JSON.parse(prov)
		oportunity.status = "Pendiente"
		oportunity.save
		JSON.parse(providers['resellers']).each do |oportunityprovider|
			provider = Provider.find_by_nit(oportunityprovider["providerId"])
			if provider.nil?
				provider = Provider.create(nit:oportunityprovider["providerId"],name:oportunityprovider["providerName"])
			end
			op = OportunityProvider.where(provider_nit:provider.nit,oportunity_identification:oportunity.identification)
			if op.blank?
				OportunityProvider.create(provider_nit:provider.nit,oportunity_identification:oportunity.identification,email:oportunityprovider["channelEmail"],vendor_name:provider.name)
			end
		end	
	end
end
