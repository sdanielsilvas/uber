class OportunityProvider < ApplicationRecord

	def self.create_providers(oportunityProviders)
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
	end
end
