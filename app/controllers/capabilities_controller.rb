class CapabilitiesController < ApplicationController
	before_filter {|controller| controller.set_selected("products")}
	def index
		@products = Product.all
		@capabilities = Capability.all
	end

	def new
		@capability = Capability.new
	end

	def create	
		@capability = Capability.create(name:params["name"],description:params["description"])
		redirect_to capabilities_path
	end
end
