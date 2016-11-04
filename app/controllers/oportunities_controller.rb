class OportunitiesController < ApplicationController
	before_action :authenticate_user!, :except => [:update,:test] 


 	skip_before_filter :verify_authenticity_token, :only => [:update,:load,:test] 
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

	def show
		@oportunity = Oportunity.find(params[:id])
		@items = OportunityItem.where(oportunity_identification:@oportunity.identification)
	end

	def test
		OportunityMailer.test("sdanielsilvas@gmail.com").deliver
	end

	def update
		status = JSON.parse(request.body.read)["status"]
		auction_id = JSON.parse(request.body.read)["auction_id"]
		oportunity = Oportunity.find_by_auction_id(auction_id)
		@updated_oportunity = Oportunity.update(oportunity.id, :status => status)
		render json: @updated_oportunity
	end

	def load
		#Oportunity.readFile(nil)
		info = Oportunity.readFile(params[:file].tempfile)
		redirect_to root_path
	end
end
