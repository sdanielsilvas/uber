class ProvidersController < ApplicationController

	before_filter :set_selected

	def index
		@providers = Provider.all
	end

	def set_selected
		@selected = 'providers'
	end
end
