class ContactsController < ApplicationController

  # allows only admin users to access these functions
  # calls an application controller function(global) to access this test.
  # I imagine we will use it in other places
  # but is it secure?
  before_action :signed_in_admin_user,     only: [:index, :update]


  def index
    # i assume this can only be used if the display is paginated?
    @contacts = Contact.paginate(page: params[:page])
  end
  
  def new
  	@contact = Contact.new
  end

  def show
  	@contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)   
    if @contact.save && contact_email
      flash[:success] = "Your Contact Message has been sent, #{@contact.name}" 

      UserMailer.contactus_email(@contact).deliver

      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    # shows edit page w form
    @contact = Contact.find(params[:id]) 
  end

  def update
    # User is now loaded with before_action :correct_user
    if @contact.update_attributes(contact_params)
      flash[:success] = "Contact Record updated"
      redirect_to @contact
    else
      render 'edit'
    end
  end

  def destroy
    Contact.find(params[:id]).destroy()
    flash[:success] = "Contact Removed"
    redirect_to contacts_url
  end



private
	def contact_email 
		true
	end

    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end

end
