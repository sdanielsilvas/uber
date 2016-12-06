class OportunityProvider < ApplicationRecord

	def self.create_providers(oportunityProviders)
		oportunityProviders = JSON.parse(oportunityProviders)
		oportunity = Oportunity.find_by_auction_id(oportunityProviders.first["opportunityId"])
		
		oportunity.status = "Finalizado"
		oportunity.finalization_date = Time.new
		oportunity.save
		oportunityProviders.each do |oportunityprovider|
			provider = Provider.find_by_nit(oportunityprovider["providerId"])
			if provider.nil?
				provider = Provider.create(nit:oportunityprovider["providerId"],name:oportunityprovider["providerName"])
			end
			op = OportunityProvider.where(provider_nit:provider.nit,oportunity_identification:oportunity.identification)
			if op.blank?
			OportunityProvider.create(provider_nit:provider.nit,oportunity_identification:oportunity.identification,
				points:oportunityprovider["points"],email:oportunityprovider["channelEmail"],
				position:oportunityprovider["offerPosition"])
			end
		end
		Oportunity.send_email
		return oportunity.status
	end

	def self.associate(providers)
		providers = JSON.parse(providers)
		oportunity = Oportunity.find_by_auction_id(providers.first["opportunityId"])
		oportunity.status = "En curso subasta"
		oportunity.save
		providers.each do |oportunityprovider|
			provider = Provider.find_by_nit(oportunityprovider["providerId"])
			if provider.nil?
				provider = Provider.create(nit:oportunityprovider["providerId"],name:oportunityprovider["providerName"])
			end
			op = OportunityProvider.where(provider_nit:provider.nit,oportunity_identification:oportunity.identification)
			if op.blank?
			
			OportunityProvider.create(provider_nit:provider.nit,oportunity_identification:oportunity.identification,
				points:oportunityprovider["points"],email:oportunityprovider["channelEmail"],
				position:oportunityprovider["offerPosition"],vendor_name:provider.name,
				price:oportunityprovider["criteriaList"][0]["offertValue"],
				training_hours:oportunityprovider["criteriaList"][1]["offertValue"],
				support_hours:oportunityprovider["criteriaList"][2]["offertValue"],
				local_support:oportunityprovider["criteriaList"][3]["ScaleValue"],
				support_availability:oportunityprovider["criteriaList"][4]["ScaleValue"],
				migration_hours:oportunityprovider["criteriaList"][5]["offertValue"])
			end
		end
	end
end
