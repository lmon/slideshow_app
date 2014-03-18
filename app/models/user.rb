class User < ActiveRecord::Base
	has_many :galleries, dependent: :destroy
	has_many :assets, dependent: :destroy
	
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, 
		length: { in: 3..64 },  
		codeless:  true #custom validator

  	validates :email, presence: true, 
  					length: { in: 6..64 },
                    uniqueness: { case_sensitive: false }, 
                    email: true # <-- custom email validator

	validates :password, length: { minimum: 6 }

	has_secure_password

	def User.new_remember_token
	    SecureRandom.urlsafe_base64
	end

  	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end
  	
  	def User.per_page
    	10
  	end
  	 
	 private

	    def create_remember_token
	      self.remember_token = User.encrypt(User.new_remember_token)
	    end
end
