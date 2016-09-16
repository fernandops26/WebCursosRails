class User < ActiveRecord::Base
	

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, length: {in: 6..12}
	has_secure_password

	has_one :person, dependent: :destroy
	accepts_nested_attributes_for :person

	before_update :encryptar

	before_create :encryptar_una_pass


	#atributo virtual
	attr_accessor :remember_token

	#Regresa una version encriptada de un String
	def self.secure_string(string)
		cost=BCrypt::Engine.cost
		BCrypt::Password.create(string,cost:cost)
	end

	#Crea un string cualquiera
	def self.generate_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token=User.generate_token
		#que es
		#update_attribute(:password_digest,User.secure_string(remember_token))
	end

	def authenticated?(remember_token)
		return false if password_digest.nil?
		#que es
		BCrypt::Password.new(password_digest).is_password?(remember_token)
	end

	def delete_cookie
		#update_attribute(:password_digest,nil)
	end

	def iguales?(password,password_digest)
		password.equal?(password_digest)
	end
	def encryptar
		cost=BCrypt::Engine.cost
		self.password_digest =BCrypt::Password.create(self.password,cost:cost)
	end

	def encryptar_una_pass
		cost=BCrypt::Engine.cost
		self.password_digest =BCrypt::Password.create(self.password_digest,cost:cost)
	end
end
