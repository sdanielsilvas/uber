class OportunitiesController < ApplicationController
	#before_action :authenticate_user!


 	skip_before_filter :verify_authenticity_token  
	def new
		Oportunity.send
		redirect_to root_path
	end

	def index
		@oportunities = Oportunity.all
	end

	def charge
		puts 'oelo'
		
	end

	def test
		
		render :json => {message:'ricardo cacorro'}	
	end

	def load
		info = Oportunity.readFile(params[:file].tempfile)
		binding.pry
	end
end
