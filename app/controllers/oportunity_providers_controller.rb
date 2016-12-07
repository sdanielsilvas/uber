class OportunityProvidersController < ApplicationController

	before_action :authenticate_user!, :except => [:finalize,:associate] 
 	skip_before_filter :verify_authenticity_token, :only => [:finalize, :associate]
 	before_action :verify_credentials, :only =>[:create]
	
	def finalize
		response = OportunityProvider.finalize(JSON.parse(request.body.read)["providers"])
		render json: response
	end

	def associate
		response = OportunityProvider.associate(JSON.parse(request.body.read)["providers"])
	end
end
