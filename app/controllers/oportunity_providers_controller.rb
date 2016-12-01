class OportunityProvidersController < ApplicationController

	before_action :authenticate_user!, :except => [:create] 
 	skip_before_filter :verify_authenticity_token, :only => [:create]
 	before_action :verify_credentials, :only =>[:create]
	
	def create
		response = OportunityProvider.create_providers(JSON.parse(request.body.read)["providers"])
		render json: response
	end
end
