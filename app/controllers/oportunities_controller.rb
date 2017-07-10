class OportunitiesController < ApplicationController

	before_action :authenticate_user!, :except => [:update,:test,:finalize,:set_participants,:test_email,:take] 
	before_action :verify_credentials, :only =>[:update]
	skip_before_filter :verify_authenticity_token, :only => [:update,:load,:test,:finalize,:set_participants,:test_email,:take] 
	layout false, only: [:take,:check_resellers,:invoice]
	before_filter {|controller| controller.set_selected("opportunities")}
	

	def new
		Oportunity.send
		redirect_to root_path
	end

	def index
		@templates = current_user.templates
		unless (params[:status].nil? || params[:status]=="All")
			@oportunities = current_user.oportunities.where(status:params[:status]).paginate(page: params[:page],per_page: 8)
			@oportunities = @oportunities.starts_with(params[:starts_with]) if params[:starts_with].present?

		else
			@oportunities = current_user.oportunities.all.paginate(page: params[:page],per_page: 8)
			@oportunities = @oportunities.starts_with(params[:starts_with]) if params[:starts_with].present?
		end 
		@status = ["All"] + current_user.oportunities.all.map{|x|x.status}.uniq
	end


	def charge
		puts 'oelo'
	end

	def show
		@oportunity = Oportunity.find(params[:id])
		@items = @oportunity.oportunity_items
		@oportunityProvider = OportunityProvider.where(oportunity_identification:@oportunity.identification).order(:position)

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
		info = Oportunity.readFile(params[:file].tempfile,current_user.id)
		redirect_to root_path
	end

	def test_email
		puts "vaa enviar un correo"
		Oportunity.send_email_sendgrid
	end

	def take
		@opportunity = Oportunity.find(params[:id])
		@opportunityProvider = OportunityProvider.find(params[:oprovider])
		@items = OportunityItem.where(oportunity_identification:@opportunity.identification)		
	end

	

	def send_client_email
		response = Oportunity.send_client_email
	end

	def default_partner
		@oportunity = Oportunity.find(params[:id])
		@oportunity.status = 'CANCELADA'
		@oportunity.save
		redirect_to root_path	
	end

	def check_resellers
		@opportunity = Oportunity.find(params['id'])
		@resellers = OportunityProvider.where(oportunity_identification:@opportunity.identification)
		
	end

	def send_to_auction
		@oportunity = Oportunity.find(params[:id])
		if @oportunity.template_id == nil
			@oportunity.status = 'Elegir plantilla'
			@oportunity.save
		else
			@oportunity.status = 'Iniciando'
			@oportunity.save
			Oportunity.send_oportunity(@oportunity)
		end
		#redirect_to root_path
	end
	def invoice
	end

end
