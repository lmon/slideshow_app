class Contact < ActiveRecord::Base
	include Validations #testing. Delete??

	#validates :name, presence: true
	validates :name, length: { maximum: 32 }, codeless:  true

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  	validates :email, presence: true, 
  			length: { in: 6..64 }, 
  			codeless:  true, 
  			email: true # <-- custom email validator

	validates :message, presence: true,
			 		length: { in: 0..512 }
 
	validates :message, codeless:  true


end
