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
	post 'contact_default_partner/:id', to: "oportunities#default_partner", as:'contact_default_partner'
	get 'check_resellers/:id', to: "oportunities#check_resellers", as:'check_resellers'
	get 'sendtoauction/:id', to: "oportunities#send_to_auction", as:'sendtoauction'
	
	#post 'send_opportunity'

	#providers routes
	get 'providers', to:"providers#index"

	get 'provider', to:"providers#new"

	post 'provider', to:"providers#create"

	#oportunity providers routes
	post 'oportunity_providers', to:"oportunity_providers#finalize"

	get 'choosed/:id', to:"oportunity_providers#choosed", as:'choosed'

	post 'credentials', to:"users#update_credentials"

	post 'accepted', to:"oportunity_providers#associate"

	post 'test_email', to:"oportunities#test_email"

	get 'take_opportunity/:id/:oprovider', to:"oportunities#take", as:'take_opportunity'

	get 'send_cotization/:id/:oprovider', to:"oportunities#invoice", as:'send_cotization'

	get 'contact/:id/:oprovider', to:"providers#contact", as:'contact'

	get 'choose/:id/:oprovider', to:"providers#choose", as:'choose'


	get 'reject/:id/:oprovider', to:"providers#reject", as:'reject'

	get 'provider/:id', to:'providers#show', as:'show_provider'

	#templates routes
	get 'templates',to:'templates#index'

	get 'templates/new',to:'templates#new'

	post 'template',to:'templates#create'

	get 'templates/:id', to:'templates#show', as:'show_template'

	#capability routes
	get 'capabilities', to:'capabilities#index'

	get 'capability', to:'capabilities#new'

	post 'capability', to:'capabilities#create'

	#products routes
	get 'product', to:'products#new'

	post 'product', to:'products#create'
end
