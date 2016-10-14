Rails.application.routes.draw do
	#root route
	root 'oportunities#index'
	#user routes
	devise_for :users
	#oportunities routes
	get 'oportunities', to:'oportunities#index'
	get 'oportunities/new', to:'oportunities#charge'
	get 'load_oportunity', to:'oportunities#new'
	post 'load_oportunity', to:'oportunities#load'
	post 'test',to:'oportunities#test'
end
