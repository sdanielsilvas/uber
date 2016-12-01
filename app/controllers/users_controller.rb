class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: :update_credentials 
	def update_credentials
		response = Credential.update_credentials(request)
		if response.respond_to?(:user_name)
			render json: response
		else
			res = {error:"ha ocurrido un error decriptando el password"}.to_json
			render :json => res, status: 401
		end
	end
end
