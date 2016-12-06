class OportunitiesController < ApplicationController
	before_action :authenticate_user!, :except => [:update,:test,:finalize,:set_participants] 
	before_action :verify_credentials, :only =>[:update]

 	skip_before_filter :verify_authenticity_token, :only => [:update,:load,:test,:finalize,:set_participants] 
	def new
		Oportunity.send
		redirect_to root_path
	end

	def index
		
		unless (params[:status].nil? || params[:status]=="Todas")
			@oportunities = Oportunity.where(status:params[:status]).paginate(page: params[:page],per_page: 5)
			@oportunities = @oportunities.starts_with(params[:starts_with]) if params[:starts_with].present?

		else
			@oportunities = Oportunity.all.paginate(page: params[:page],per_page: 5)
			@oportunities = @oportunities.starts_with(params[:starts_with]) if params[:starts_with].present?
		end 
		@status = ["Todas"] + Oportunity.all.map{|x|x.status}.uniq
	end


	def charge
		puts 'oelo'
	end

	def show
		@oportunity = Oportunity.find(params[:id])
		@items = OportunityItem.where(oportunity_identification:@oportunity.identification)
		@oportunityProvider = OportunityProvider.where(oportunity_identification:@oportunity.identification)
				
	end

	def test
		OportunityMailer.test("sdanielsilvas@gmail.com").deliver
	end

	def update
		json = JSON.parse(request.body.read)
		status = json["status"]
		auction_id = json["auction_id"]
		oportunity = Oportunity.find_by_auction_id(auction_id)
		@updated_oportunity = Oportunity.update(oportunity.id, :status => status)

		render json: @updated_oportunity
	end

	def finalize
		oportunity = Oportunity.find(params["id"].to_i)
		oportunity.status = "Confirmado"
		oportunity.save
	end
	

	def load
		#Oportunity.readFile(nil)
		info = Oportunity.readFile(params[:file].tempfile)
		redirect_to root_path
	end

end
