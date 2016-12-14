class OportunityMailer < ApplicationMailer
	default from: 'notifications@example.com'
	
	def test(to,op,oprovider)
		@oportunity = op
		@oportunityProvider = oprovider
		@url  = 'http://example.com/login'
		mail(to: to, subject: 'Resultado Subasta')
	end
end

