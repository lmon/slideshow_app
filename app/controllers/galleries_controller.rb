class GalleriesController < ApplicationController
#  restrict actiions based on this Sessions Helper function
before_action :signed_in_user, only: [:create, :destroy, :update, :new, :edit]
before_action :set_gallery, only: [:show, :shareview, :edit, :update, :destroy]
before_action :set_assets, only: [:show, :edit, :new, :create,]
before_action :set_options, only: [:show, :shareview]

# allows users to access these functions only for them elves
before_action :correct_user,   only: [:edit, :update]

protect_from_forgery only: [:sort]

layout :resolve_layout


  def index
    # i assume this can only be used if the display is paginated?
    @galleries = Gallery.paginate(page: params[:page])
  end

  def new
  	@gallery = Gallery.new
  end

  def show
  end

  def edit
    # this gallery
    @gallery2 = Gallery.find(params[:id])
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
      flash[:success] = "Gallery created!"
      redirect_to @gallery
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
      redirect_to current_user 
     else # you don
      flash[:success] = "Action Not Allowed by You"
      redirect_to root_url
   end
  end
  
# the share able version of the gallery
# handles all loaded slideshow options
# uses a different layout 
# view options:
# 2 (default) -  a homemde Jquery click through gallery 
# 3 - color box
# 4 - Bootstrap gallery
  def shareview
    if @view_options.has_key?(params[:v].to_i) 
      if params[:v] == "2"
        render 'show_basic' 
      else
        page = 'show'+ params[:v] 
        render page
      end
    else
      render 'show_basic' 
    end

  end 


# for use on sorting of assets
# called via ajax from the gallery edit form
def sort
  order = params[:asset]
    if order.nil?
      render json: {:kind => 'error', message: 'missing order' } 
    end

    gid = params[:id]
  
    if gid.nil?
      render json: {:kind => 'error', order: 'missing gid' } unless gid.nil?
    end


    if Gallery.find(gid).update_attributes(:asset_order => order.join(','))
      render json: {:kind => 'success', :order => order, :gid=>gid} 
    else
      render json: {:kind => 'error', :message=>'update order'} 
    end

  end

 private 

  def resolve_layout
    case action_name
      when "shareview"
        "shareview"
      else
        "application"
      end
  end

    
  def gallery_params
      params.require(:gallery).permit(:title, {:asset_ids => []}, :asset_order, :friendly_name, :private)
    end
    
    def set_gallery
      @gallery = Gallery.find(params[:id])  
    end

    def set_options
      @view_options = { 2=>"basic" ,3=>"cb" ,4=>"bs", 5=>"rambling"  }
    end

    def set_assets
      
      if current_user.nil? 
        # logged out viewing, use the id of the user from the gallery
        @myid = @gallery.user_id 
      else
        @myid = current_user.id
      end
      
      @allassets = Asset.where(:user_id => @myid)       

      @usedsortedassets = Array.new 

      if !@gallery.nil?    
        a = @gallery.asset_order.to_s.split(",")
        
        #[TODO]
        #[OPTIMIZE]
        # another try (very inefficient)
        a.each do |targetid| 
          @allassets.each do |element|
            if element.id.to_s == targetid.to_s
                @usedsortedassets.push( element )
                break
            end
          end
        end 
      end # end if any
        @usedsortedassets
    end
  
    def correct_user
      @user = User.find(@gallery.user_id)
      redirect_to(root_url) unless current_user?(@user)
    end
end
