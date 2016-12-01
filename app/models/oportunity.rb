class Oportunity < ApplicationRecord
	validates_uniqueness_of :identification
	#belongs_to :user
	#has_many :items, class_name: "OportunityItem", foreign_key: "oportunity_identification"
	ALGORITHM = "AES-128-CBC"

		KEY = "61d87fb0e30a9b3e"
		IV = "027c1146b1b8f927"

	# cipher = OpenSSL::Cipher.new(ALGORITHM)
	# cipher.encrypt()
	# cipher.key = key
	# cipher.iv = iv
	# crypt = cipher.update("This is superior to unauthenticated modes in that it allows to detect if somebody effectively changed the ciphertext after it had been encrypted. This prevents malicious modifications of the ciphertext that could otherwise be exploited to modify ciphertexts in ways beneficial to potential attackers") + cipher.final()
	# crypt_string = (Base64.encode64(crypt))
	# puts "asi lo encripta en base 64"
	# puts crypt_string




	# cipher = OpenSSL::Cipher.new(ALGORITHM)
	# cipher.decrypt()
	# cipher.key = key
	# cipher.iv = iv
	# ricardo = "YrgJ6Ii3KrfVnXE4OsnoQT5FtJnkYLnmbs7si5TnTvYOM/8EgtHZrpzgXKXMm6pw"
	# tempkey = Base64.decode64(ricardo)
	# crypt = cipher.update(tempkey)
	# crypt << cipher.final()
	# puts "asi lo desencripta"
	# puts crypt

	def self.readFile(file_path)
		# oportunity = Oportunity.first
		# items = OportunityItem.where(oportunity_identification:oportunity.identification)
		# message = {oportunity:oportunity,items:items}
		# resp = RestClient.post 'http://10.0.0.13:8084/SubastaV4.2/api/createprocess/crearsubasta', {oportunity: message}.to_json, :content_type => "application/json"
		xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
		createOportunities(xlsx)
		return xlsx.info
	end

	def self.send_email
		oportunities = Oportunity.where(status:"Finalizado")
		oportunities.each do |oportunity|

			email = OportunityProvider.where(oportunity_identification:oportunity.identification).where(position:"1").first.email
			
			#OportunityMailer.test(email,oportunity.id).deliver
		end
		
	end

	private

	def self.createOportunities(sheet)
		2.upto(sheet.last_row) do |row_index|
			row = sheet.sheet(0).row(row_index)
			auction_id = row[0].to_s+row[4]
			oportunity = Oportunity.new(identification:row[0],oportunity_source:row[1],assigned_partner:row[2],
				status:row[3],company_name:row[4],contact_email:row[18],business_phone:row[19],auction_id:auction_id)
			if oportunity.save
				if (createOportunityItem(sheet,oportunity))
					send_oportunity(oportunity)
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
		message = {user_name:user_name,password:password_crypt, oportunity:oportunity,items:items}
		begin
			resp = RestClient.post 'http://10.0.0.13:8084/SubastaV4.2/api/createprocess/crearsubasta', {oportunity: message}.to_json, :content_type => "application/json"
			puts resp
		rescue RestClient::Exception => e
			puts e.http_body
		end
	end
end
