class OportunityMailer < ApplicationMailer
	default from: 'notifications@example.com'
	
	def test(to)
		@url  = 'http://example.com/login'
		mail(to: to, subject: 'Welcome to My Awesome Site')
	end
end

