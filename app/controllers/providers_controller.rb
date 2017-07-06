class ProvidersController < ApplicationController

	before_filter :set_selected

	layout false, only: [:contact,:reject]

	def index
		@providers = Provider.all
	end

	def new
		@provider = Provider.new
	end

	def create
		Provider.create(name:params['name'],email:params['email'])
		redirect_to providers_path
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

	def contact
		@opportunity = Oportunity.find(params[:id])
		@opportunityProvider = OportunityProvider.find(params[:oprovider])
		@items = OportunityItem.where(oportunity_identification:@opportunity.identification)
		Provider.contact(@opportunity,@opportunityProvider)
	end
	def choose
		@opportunity = Oportunity.find(params[:id])
		@opportunity.status = 'Elegida'
		@opportunity.save
		@opportunityProvider = OportunityProvider.find(params[:oprovider])
		@items = OportunityItem.where(oportunity_identification:@opportunity.identification)
		Provider.choose(@opportunity,@opportunityProvider)
	end

	def reject
		@opportunity = Oportunity.find(params[:id])
		@opportunityProvider = OportunityProvider.find(params[:oprovider])
		@items = OportunityItem.where(oportunity_identification:@opportunity.identification)
		
		Provider.reject(@opportunity,@opportunityProvider)
	end
end
