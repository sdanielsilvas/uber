class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def verify_credentials
  	if !Credential.valid_credentials(request)
  		res = {error:"ha ocurrido un error decriptando el password"}.to_json
  		render :json => res
  	end
  end
  
end
