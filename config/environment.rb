# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#config.action_mailer.default_url_options = { :host => 'https://desolate-meadow-84025.herokuapp.com' }
ActionMailer::Base.smtp_settings = {
  :user_name => 'sdanielsilvas123',
  :password => 'send1234',
  :domain => 'herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

