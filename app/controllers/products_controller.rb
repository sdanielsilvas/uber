class ProductsController < ApplicationController
	def new
		@capabilities = Capability.all
		@product = Product.new
	end

	def create
		product = Product.createPorduct(params['product'],params['capabilities'])
		redirect_to capabilities_path
	end
end
