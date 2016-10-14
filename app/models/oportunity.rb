class Oportunity < ApplicationRecord
	def self.send
		begin
			resp = RestClient.get 'http://10.0.0.12:8084/SubastaV4.2/api/saluda/bien', {param1: 'one'}
			#binding.pry
		rescue RestClient::Exception => e
			puts e.http_body
		end		
	end

	def self.readFile(file_path)
		xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
		return xlsx.info
	end

end
