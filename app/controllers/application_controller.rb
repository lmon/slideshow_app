class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  include SessionsHelper

  def validate_user_as_admin() # might need to pass id and current_user
    if current_user_is_admin # in sessions helper
 
     else
        flash[:error] = "You Do Not Belong!"
        redirect_to root_url
    end
  end

  def record_not_found
    flash[:success] = "There was a problem!"
    render 'shared/record_not_found'
  end
  
end
