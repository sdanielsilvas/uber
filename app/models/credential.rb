class Credential < ApplicationRecord
	belongs_to :user

	ALGORITHM = "AES-128-CBC"
	def self.update_credentials(request)
		new_credentials = JSON.parse(request.body.read)
		credentials = Credential.first
		cipher_key = OpenSSL::Cipher.new(ALGORITHM)
		cipher_key.decrypt()
		cipher_key.key = credentials.key
		cipher_key.iv = credentials.iv
		cipher_iv = OpenSSL::Cipher.new(ALGORITHM)
		cipher_iv.decrypt()
		cipher_iv.key = credentials.key
		cipher_iv.iv = credentials.iv
		cipher_password = OpenSSL::Cipher.new(ALGORITHM)
		cipher_password.decrypt()
		cipher_password.key = credentials.key
		cipher_password.iv = credentials.iv
		new_cypher_key_aux = new_credentials["key"]
		new_cypher_iv_aux = new_credentials["initialization"]
		new_cypher_password_aux = new_credentials["password"]
		new_cypher_key = Base64.decode64(new_cypher_key_aux)
		new_cypher_iv = Base64.decode64(new_cypher_iv_aux)
		new_cypher_password = Base64.decode64(new_cypher_password_aux)
		begin
			new_key = cipher_key.update(new_cypher_key)
			new_key << cipher_key.final()
			new_iv = cipher_iv.update(new_cypher_iv)
			new_iv << cipher_iv.final()
			new_password = cipher_password.update(new_cypher_password)
			new_password << cipher_password.final()
			credentials.update(password:new_password,iv:new_iv,key:new_key)
			return credentials
		rescue Exception => e
			return e
		end
		
		
	end

	def self.valid_credentials(request)
		request = JSON.parse(request.body.read)
		user_name = request["user_name"]
		credentials = Credential.first
		decoded = decrypt(credentials,request["password"])
		if (decoded == credentials.password)
			return true
		end
		return false
	end

	def self.crypt(credentials,secret)
		cipher = OpenSSL::Cipher.new(ALGORITHM)
		cipher.encrypt()
		cipher.key = credentials.key
		cipher.iv = credentials.iv
		crypt = cipher.update(secret) + cipher.final()
		crypt_string = (Base64.encode64(crypt))
		return crypt_string
	end

	private

	def self.decrypt(credentials,secret)
		cipher = OpenSSL::Cipher.new(ALGORITHM)
		cipher.decrypt()
		cipher.key = credentials.key
		cipher.iv = credentials.iv
		tempSecret = Base64.decode64(secret)
		begin
			crypt = cipher.update(tempSecret)
			crypt << cipher.final()
		rescue Exception => e
			crypt = e
		end
		return crypt
	end
end
