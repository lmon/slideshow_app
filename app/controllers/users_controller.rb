class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user,   only: [:edit, :update]

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

  def edit
    # shows edit page w form
    #@user = User.find(params[:id]) User is now loaded with before_action :correct_user
  end

  def update
    # User is now loaded with before_action :correct_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters
    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end


end
