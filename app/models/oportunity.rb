class Oportunity < ApplicationRecord
	# def self.send
	# 	begin
	# 		resp = RestClient.get 'http://10.0.0.12:8084/SubastaV4.2/api/saluda/bien', {param1: 'one'}
	# 		#binding.pry
	# 	rescue RestClient::Exception => e
	# 		puts e.http_body
	# 	end		
	# end

	def self.readFile(file_path)
		xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
		createOportunities(xlsx)
		binding.pry
		return xlsx.info
	end

	private
	def createOportunities(sheet)
		2.upto(xlsx.last_row) do |row_index|
			puts xlsx.sheet(0).row(row_index)
		end
	end
end
