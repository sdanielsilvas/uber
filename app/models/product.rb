class Product < ApplicationRecord
	has_and_belongs_to_many :capabilities


	def self.createPorduct(productAttrs,capabilities)
		product = Product.new(name:productAttrs['name'],description:productAttrs['description'])
		capabilities.each do |capability|
			cap = Capability.find(capability)
			product.capabilities << cap
		end
		product.save
		return product
	end
end
