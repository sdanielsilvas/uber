class OportunityProvider < ApplicationRecord

	def self.finalize(prov)
		providers = JSON.parse(prov)
		oportunity = Oportunity.find_by_auction_id(providers.first["opportunityId"])
		oportunity.status = "Finalizada"
		oportunity.save
		providers.each do |oportunityprovider|
			provider = Provider.find_by_nit(oportunityprovider["providerId"])
			if provider.nil?
				provider = Provider.create(nit:oportunityprovider["providerId"],name:oportunityprovider["providerName"])
			end

			oportunityprovider["criteriaList"].each do |criteria|
				case criteria["criteriaId"]
				when "1"
					@price = criteria["offertValue"]
				when "2"
					@training_hours = criteria["offertValue"]
				when "3"
					@support_hours = criteria["offertValue"]
				when "4"
					@local_support = criteria["ScaleValue"]
				when "5"
					@support_availability = criteria["ScaleValue"]
				else
					@migration_hours = criteria["offertValue"]
				end
			end
			op = OportunityProvider.where(provider_nit:provider.nit,oportunity_identification:oportunity.identification)
			
			op.update(provider_nit:provider.nit,oportunity_identification:oportunity.identification,
				points:oportunityprovider["points"],email:oportunityprovider["channelEmail"],
				position:oportunityprovider["offerPosition"],vendor_name:provider.name,
				price:@price,
				training_hours:@training_hours,
				support_hours:@support_hours,
				local_support:@local_support,
				support_availability:@support_availability,
				migration_hours:@migration_hours)
			
		end
		Oportunity.send_winner_email(oportunity)
		return oportunity.status
	end

	def self.associate(prov)
		providers = JSON.parse(prov)
		oportunity = Oportunity.find_by_auction_id(providers.first["opportunityId"])
		oportunity.status = "EN CURSO_SUBASTA"
		oportunity.save
		providers.each do |oportunityprovider|
			provider = Provider.find_by_nit(oportunityprovider["providerId"])
			if provider.nil?
				provider = Provider.create(nit:oportunityprovider["providerId"],name:oportunityprovider["providerName"])
			end
			op = OportunityProvider.where(provider_nit:provider.nit,oportunity_identification:oportunity.identification)
			if op.blank?

				oportunityprovider["criteriaList"].each do |criteria|
					case criteria["criteriaId"]
					when "1"
						@price = criteria["offertValue"]
					when "2"
						@training_hours = criteria["offertValue"]
					when "3"
						@support_hours = criteria["offertValue"]
					when "4"
						@local_support = criteria["ScaleValue"]
					when "5"
						@support_availability = criteria["ScaleValue"]
					else
						@migration_hours = criteria["offertValue"]
					end
				end
				OportunityProvider.create(provider_nit:provider.nit,oportunity_identification:oportunity.identification,
					points:oportunityprovider["points"],email:oportunityprovider["channelEmail"],
					position:oportunityprovider["offerPosition"],vendor_name:provider.name,
					price:@price,
					training_hours:@training_hours,
					support_hours:@support_hours,
					local_support:@local_support,
					support_availability:@support_availability,
					migration_hours:@migration_hours)
			end
		end
	end
end
