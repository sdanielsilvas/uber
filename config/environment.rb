# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

config.action_mailer.default_url_options = { :host => 'localhost' }
ActionMailer::Base.smtp_settings = {
  :user_name => 'Intergrupo',
  :password => 'Intergrupo2016',
  :domain => 'herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

