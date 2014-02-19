class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	
	validates :name, presence: true
	validates :name, length: { in: 6..64 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
	validates :email, length: { in: 6..64 }
end
