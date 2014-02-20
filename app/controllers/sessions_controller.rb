class SessionsController < ApplicationController

	def new
		#uses default view path
  	end

  	def create
  		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
	    	# Sign the user in and redirect to the user's show page.
			sign_in user
      		redirect_to user #goes to profile
    	else
		    # Create an error message and re-render the signin form.
			flash.now[:error] = "You've got Issues"
		  	render 'new'
	  	end
   	end

  	def destroy
  		sign_out
  		redirect_to root_path
  	end

end
