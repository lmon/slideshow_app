class UsersController < ApplicationController
  # these are each auto-run before the specified methods
  # allows only signed in users to access these functions
  before_action :signed_in_user, only: [:edit, :update]
  before_action :signed_in_user_no_access, only: [:new, :create]
  
  # allows users to access these functions only for them elves
  before_action :correct_user,   only: [:edit, :update]
  # allows only admin users to access these functions
  before_action :admin_user,     only: :destroy

  def index
    # i assume this can only be used if the display is paginated?
    @users = User.paginate(page: params[:page])
  end
  
  def new
  	@user = User.new
  end

  def show
  	@user = User.includes(:assets).find(params[:id])
    @galleries = @user.galleries.paginate(page: params[:page])
    #@assets = @user.assets
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user # auto sign in
      link = ""#view_context.link_to( "Sign up now!", signup_path )    
    	flash[:success] = " Welcome to the inner circle. #{link} ".html_safe

      # Tell the UserMailer to send a welcome Email after save
      UserMailer.welcome_email(@user).deliver
      UserMailer.newuser_notifyme(@user).deliver
  
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
    
    # on update, you might not want to re-enter password. if its blank, dont try to update
    # see model for second part
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    # prevents user from deleting self
    @user = User.find(params[:id])
    if @user.id == current_user.id 
      redirect_to root_url
    else
      @user.destroy
      respond_to do |format|
      format.html
      format.js
      #flash[:success] = "User Removed"
      #redirect_to users_url
      end
   end
    
  end
 

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def signed_in_user_no_access
      store_location
      redirect_to root_url if current_user
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
