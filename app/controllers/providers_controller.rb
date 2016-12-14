class ProvidersController < ApplicationController

	before_filter :set_selected

	def index
		@providers = Provider.all
	end

	def set_selected
		@selected = 'providers'
	end

	def show 
		@provider = Provider.find(params[:id])
		op = OportunityProvider.where(provider_nit: @provider.nit)
		@oportunities = []
		op.each do |o|
			@oportunities << Oportunity.find_by_identification(o.oportunity_identification)
		end
	end
end
