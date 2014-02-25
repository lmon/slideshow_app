class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def validate_user_as_admin() #might need to pass id and current_user
    if current_user_is_admin # in sessions helper
      # continue to current_user url
      #  flash[:success] = "#{session[:name]} You are an admin"
    else
        flash[:error] = "You are not an admin!"
        redirect_to root_url
    end
  end

  
  

end
