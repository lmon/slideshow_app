class GalleriesController < ApplicationController
#  restrict actiions based on this Sessions Helper function
before_action :signed_in_user, only: [:create, :destroy]
before_action :set_gallery, only: [:show, :edit, :update, :destroy]



  def index
    # i assume this can only be used if the display is paginated?
    @galleries = Gallery.paginate(page: params[:page])
  end

  def new
  	@gallery = Gallery.new
  end

  def show
    #@gallery = Gallery.find(params[:id])
  
  end
  
 def edit
    #@gallery = Gallery.find(params[:id])

  end

  def update
    # User is now loaded with before_action :correct_user
    if @gallery.update(gallery_params)
      flash[:success] = "Gallery updated"
      redirect_to @gallery
    else
      render 'edit'
    end

  end
  
  def create
    @gallery = current_user.galleries.build(gallery_params)
    if @gallery.save
      flash[:success] = "gallery created!"
      redirect_to root_url
    else
      #redirect_to user_path(current_user)
      render 'new'
    end
  end

  def destroy
     # prevents user from deleting self
    if current_user && (@gallery.user_id == current_user.id )
      Gallery.find(params[:id]).destroy()
      flash[:success] = "Gallery Removed"
      redirect_to users_url

     else # you don
      flash[:success] = "Action Not Allowed by You"
      redirect_to root_url
   end

  end

 private 

    def gallery_params
      params.require(:gallery).permit(:title, :asset_list, :asset_order, :friendly_name, :private)
    end
    def set_gallery
    @gallery = Gallery.find(params[:id])
  
  end
  
end
