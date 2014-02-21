class UsersController < ApplicationController
  def index
    @users = User.all()
  end
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user # auto sign in
      link = ""#view_context.link_to( "Sign up now!", signup_path )    
    	flash[:success] = " Welcome to the inner circle. #{link} ".html_safe
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
