class User < ActiveRecord::Base
  	 
  	GALLERIES_LIMIT =  30
  	ASSETS_LIMIT = 50

	has_many :galleries, dependent: :destroy
	has_many :assets, dependent: :destroy
	
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	before_create { generate_token(:auth_token) } 

	validates :name, presence: true, 
		length: { in: 3..64 },  
		codeless:  true #custom validator

  	validates :email, presence: true, 
  					length: { in: 6..64 },
                    uniqueness: { case_sensitive: false }, 
                    email: true # <-- custom email validator

	validates :password, length: { minimum: 6 }, :if => :password

	has_secure_password

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end
		
	def User.new_remember_token
	    SecureRandom.urlsafe_base64
	end

  	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end
  	
  	def User.per_page
    	10
  	end
  	
	##
	def reached_assets_limit?
	  self.assets.count >= ASSETS_LIMIT
	end
	##
	def reached_galleries_limit?
	  self.galleries.count >= GALLERIES_LIMIT
	end
	##
	# used for login remember 
	def generate_token(column)
		begin self[column] = SecureRandom.urlsafe_base64(10)
		end while User.exists?(column => self[column])
	end

	 private
	 	# used for for login cookie
	    def create_remember_token
	      self.remember_token = User.encrypt(User.new_remember_token)
	    end
end
