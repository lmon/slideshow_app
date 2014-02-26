class GalleriesController < ApplicationController
#  restrict actiions based on this Sessions Helper function
before_action :signed_in_user, only: [:create, :destroy]

def index
    # i assume this can only be used if the display is paginated?
    @galleries = Gallery.paginate(page: params[:page])
  end

  def new
  	@gallery = Gallery.new
  end

=begin
  def show
    @gallery = Gallery.find(params[:id])
  end
  def edit
    @gallery = Gallery.find(params[:id])

  end

  def update
  end
    
=end  

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
  end

 private

    def gallery_params
      params.require(:gallery).permit(:title, :friendly_name,:private)
    end
  
end
