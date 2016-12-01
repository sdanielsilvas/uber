class OportunityMailer < ApplicationMailer
	default from: 'notifications@example.com'
	
	def test(to,id)
		@id = id
		@url  = 'http://example.com/login'
		mail(to: to, subject: 'Ganaste')
	end
end

