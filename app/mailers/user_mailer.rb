class UserMailer < ActionMailer::Base
  #default from: "lmonaco@lucasmonaco.com"
	
	def welcome_email(user)

		@user = user
		@url  = 'https://murmuring-ridge-6792.herokuapp.com/'
		mail(from: "lmonaco@lucasmonaco.com", to: @user.email, subject: 'Site: Welcome to My Awesome Site')

	end

	def newuser_notifyme(user)

		@user = user
		mail(from: "lmonaco@lucasmonaco.com", to: @user.email, subject: 'Site: New User to the Site')
	end

	#def user_reset_password(user)
	#	@user = user
	#	mail(from: "lmonaco@lucasmonaco.com", to: @user.email, subject: 'Site: Reset Password')
	#
	#end

	def password_reset(user)
  		@user = user
  		mail(from: "lmonaco@lucasmonaco.com", :to => user.email, :subject => 'Site: Password Reset')
	end

	
	def contactus_email(contact)
		@contact_name = contact.name
		@contact_email = contact.email
		@contact_message = contact.message
		mail(from: "lmonaco@lucasmonaco.com", to: "luke@lucasmonaco.com", subject: 'Site: Contact Us')

	end

end
