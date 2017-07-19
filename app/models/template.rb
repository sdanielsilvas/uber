class Template < ApplicationRecord
	belongs_to :user

	def self.getTemplates
		resp = RestClient.get('http://www.serviciosenweb.com:2527/AuctionOpportunities/api/biddingresource/templates')
	end
end
