class UserMailer < ActionMailer::Base
  #default from: "lmonaco@lucasmonaco.com"
	
	def welcome_email(user)

		@user = user
		@url  = 'https://murmuring-ridge-6792.herokuapp.com/'
		mail(from: "lmonaco@lucasmonaco.com", to: @user.email, subject: 'Welcome to My Awesome Site')

	end


end
