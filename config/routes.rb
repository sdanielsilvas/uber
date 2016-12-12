Rails.application.routes.draw do
	#root route
	root 'oportunities#index'
	#user routes
	devise_for :users
	#oportunities routes
	get 'oportunities', to:'oportunities#index'
	get 'oportunity/:id', to:'oportunities#show', as:'show_oportunity'
	get 'oportunities/new', to:'oportunities#charge'
	get 'load_oportunity', to:'oportunities#new'
	post 'load_oportunity', to:'oportunities#load'
	get 'test', to:'oportunities#test'
	put 'oportunities', to:"oportunities#update"
	get 'finalize_oportunity/:id', to: "oportunities#finalize", as:'finalize_oportunity'

	#providers routes
	get 'providers', to:"providers#index"

	#oportunity providers routes
	post 'oportunity_providers', to:"oportunity_providers#finalize"

	post 'credentials', to:"users#update_credentials"

	post 'accepted', to:"oportunity_providers#associate"

	post 'test_email', to:"oportunities#test_email"
end
