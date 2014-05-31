module SessionsHelper
  #def sign_in(user)
  #    remember_token = User.new_remember_token
  #    # to do: make cookie session shorter
  #    cookies.permanent[:remember_token] = remember_token
  #    user.update_attribute(:remember_token, User.encrypt(remember_token)) #User.digest(remember_token))
  #    self.current_user = user
  #end

  # original from mhartl: trying to fix logged in on signup issue
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end


  #def sign_out
  #	current_user.update_attribute(:remember_token,
  #                              User.encrypt(User.new_remember_token))
  #	# for login remember
  #  	cookies.delete(:auth_token)
  #    #user.update_attribute(:remember_token, "")
  #   self.current_user = nil
  #    cookies.delete :user
  #end

  # original from mhartl: trying to fix logged in on signup issue
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  #def current_user
  #	remember_token = User.encrypt(cookies[:remember_token])
  #	#@current_user ||= User.find_by(remember_token: remember_token)
  #	@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  #end

  ##
  # 0530: I think the probelm was this line: @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  # auth_token token may be from the remember me part of the project. inconsistent cookie element names ....?
  ##

  # original from mhartl: trying to fix logged in on signup issue
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end


  def signed_in_user
    store_location
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def signed_in_admin_user
    redirect_to(root_url) unless ( signed_in? && current_user.admin? )
  end


  def signed_in_as_admin_user?
    ( signed_in? && current_user.admin? )
  end

  def signed_in?
    !current_user.nil?
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end
