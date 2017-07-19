class OportunityMailer < ApplicationMailer
	default from: 'notifications@example.com'
	
	def test(to,op,oprovider)
		@oportunity = op
		@oportunityProvider = oprovider
		@url  = 'http://example.com/login'
		mail(to: to, subject: 'Resultado Subasta')
	end

	def client_email(to,op,oprovider)
		@oportunity = op
		@oportunityProvider = oprovider
		@url  = 'http://example.com/login'
		mail(to: to, subject: 'Licencias microsoft')
	end

	def resellers(to,op,resellers)
		@oportunity = op
		@resellers = resellers
		@url  = 'http://example.com/login'
		mail(to: to, subject: 'Resellers list')
	end

	def choosed(to,op,resellers)
		@oportunity = op
		@resellers = resellers
		@url  = 'http://example.com/login'
		mail(to: to, subject: 'Licesing opportunity')
	end

	def invoice(to,opportunity,file)
		@opportunity = opportunity
		attachments['invoice.pdf'] = File.read(file.path)
		@url  = 'http://example.com/login'
		binding.pry
		mail(to: to, subject: 'Licesing opportunity')
	end

end

