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
	get 'test',to:'oportunities#test'
	put 'oportunities', to:"oportunities#update"
end
