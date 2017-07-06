
class Oportunity < ApplicationRecord
	#self.primary_key = "identification"
	validates_uniqueness_of :identification
	belongs_to :user
	has_many :oportunity_items, foreign_key: :oportunity_identification,primary_key: :identification
	#has_and_belongs_to_many :providers

	ALGORITHM = "AES-128-CBC"

	scope :starts_with, -> (identification) { where("identification like ? OR contact_email like ?", "#{identification}%", "#{identification}%")}



	def self.readFile(file_path,user)
		xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
		createOportunities(xlsx,user)
		return xlsx.info
	end

	def self.send_email
		oportunities = Oportunity.where(status:"Finalizado")
		oportunities.each do |oportunity|
			op = OportunityProvider.where(oportunity_identification:oportunity.identification)
			unless op.blank?
				op1 = op.where(position:"1").first
				email = op1.email
				
				OportunityMailer.test(email,oportunity,op1).deliver
			end			
		end	
	end

	def self.send_client_email(oportunity)
		op = OportunityProvider.where(oportunity_identification:oportunity.identification)
		unless op.blank?
			op1 = op.where(id:oportunity.current_provider).first
			email = oportunity.contact_email
			OportunityMailer.client_email(email,oportunity,op1).deliver
		end		
	end

	def self.send_winner_email(oportunity)
		op = OportunityProvider.where(oportunity_identification:oportunity.identification)
		unless op.blank?
			op1 = op.where(id:oportunity.current_provider).first
			email = op1.email
			OportunityMailer.test(email,oportunity,op1).deliver
		end	
	end

	def self.send_resellers_email(oportunity,resellers)
		op = OportunityProvider.where(oportunity_identification:oportunity.identification)
		unless op.blank?
			OportunityMailer.resellers("ssilva@intergrupo.com",oportunity,resellers).deliver
		end	
	end
	

	private

	def self.createOportunities(sheet,user)
		2.upto(sheet.last_row) do |row_index|
			row = sheet.sheet(0).row(row_index)
			auction_id = row[0].to_s+row[4]
			oportunity = Oportunity.new(user_id:user,identification:row[0],oportunity_source:row[1],assigned_partner:row[2],
				status:'Pendiente',company_name:row[4],contact_email:row[18],business_phone:row[19],auction_id:auction_id)
			
			#binding.pry
			

			if oportunity.save
				if (createOportunityItem(sheet,oportunity))
					#send_oportunity(oportunity)
					capabilities = getCapabilities(sheet,oportunity)
					resellers = sendCapabilities(capabilities)
					Provider.createProviders(resellers,oportunity)
					send_resellers_email(oportunity,JSON.parse(resellers))
					puts "oportunidad creada"
				else
					puts "borrando la oportunidad" + oportunity.identification
					oportunity.destroy
				end
			else
				puts oportunity.errors
			end
			
		end
	end

	def self.getCapabilities(sheet,oportunity)
		capabilities = []
		2.upto(sheet.sheet(1).last_row) do |item_index| 
			item = sheet.sheet(1).row(item_index)
			if item[0].to_s==oportunity.identification
				product = Product.find_by_name(item[1])
				unless product.nil?
					capabilities << product.capabilities
				end
			end
		end
		return capabilities
	end

	def self.getOportunityCapabilities(oportunity)
		capabilities = []
		items = oportunity.oportunity_items
		items.each do |item| 
			product = Product.find_by_name(item.product)
			unless product.nil?
				capabilities << product.capabilities
			end
		end
		message = {}
		i = 0
		capabilities.each do |capability|
			message[i] = []
			capability.each do |c|
				message[i] << {valor:c.name}
			end
			i = i + 1
		end
		return message
	end

	def self.sendCapabilities(capabilities)
		message = {}
		message["items"]={}
		i = 0
		capabilities.each do |capability|
			message["items"][i] = []
			capability.each do |c|
				message["items"][i] << {valor:c.name}
			end
			i = i + 1
		end
		msg = message.to_json
		resp = RestClient.get('http://192.168.1.89:8084/SubastaV4.2/api/biddingresource/resellers'+'?jsson='+msg)
		#resp = "{\"resellers\":[{\"providerId\":\"FOR-ASOC-TMP-785\",\"channelEmail\":\"oferenteprueba001@gmail.com\",\"channelName\":\"Prueba SEW 001\",\"offerPosition\":0},{\"providerId\":\"FOR-ASOC-TMP-786\",\"channelEmail\":\"oferenteprueba002@gmail.com\",\"channelName\":\"Prueba SEW 002\",\"offerPosition\":0}]}"
		return resp
	end

	def self.createOportunityItem(sheet,oportunity)
		have_items = false
		2.upto(sheet.sheet(1).last_row) do |item_index| 
			item = sheet.sheet(1).row(item_index)
			if item[0].to_s==oportunity.identification
				OportunityItem.create(oportunity_identification:item[0],product:item[1],sku:item[2],
					quantity:item[3],unit_price:item[4])
				have_items = true
			end
		end
		return true
	end

	def self.send_oportunity(oportunity)
		credential = Credential.first
		cipher = OpenSSL::Cipher.new(ALGORITHM)
		cipher.encrypt()
		cipher.key = credential.key
		cipher.iv = credential.iv
		crypt = cipher.update("uber") + cipher.final()
		user_crypt = (Base64.encode64(crypt))
		user_name = "microsoft"
		puts "asi lo encripta en base 64"
		puts user_crypt
		cipher = OpenSSL::Cipher.new(ALGORITHM)
		cipher.encrypt()
		cipher.key = credential.key
		cipher.iv = credential.iv
		crypt = cipher.update(credential.password) + cipher.final()
		password_crypt = (Base64.encode64(crypt))
		puts "asi lo encripta en base 64"
		puts password_crypt
		items = OportunityItem.where(oportunity_identification:oportunity.identification)
		capabilities = getOportunityCapabilities(oportunity)
		message = {user_name:user_name,password:password_crypt, oportunity:oportunity,items:items,products:capabilities}
		begin
			#resp = RestClient.post 'http://www.serviciosenweb.com:2527/AuctionOpportunities/api/biddingresource/crearsubasta', {oportunity: message}.to_json, :content_type => "application/json"
			resp = RestClient.post 'http://192.168.1.89:8084/SubastaV4.2/api/biddingresource/crearsubasta', {oportunity: message}.to_json, :content_type => "application/json"
			puts '####################### Response ###################################'
			puts resp
		rescue RestClient::Exception => e
			puts e.http_body
		end
	end
end
