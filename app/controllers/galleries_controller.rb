class GalleriesController < ApplicationController
#  restrict actiions based on this Sessions Helper function
before_action :signed_in_user, only: [:create, :destroy, :update, :new, :edit]
before_action :set_gallery, only: [:show, :edit, :update, :destroy]

protect_from_forgery only: [:sort]

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
    # all my assets
    @allassets = Asset.where(:user_id => current_user.id)
    # this gallery
    @gallery2 = Gallery.find(params[:id])
    #@allassets2 = Asset.where(:user_id => current_user.id)
    # array of ids from asste order column
    @asset_orderids = @gallery2.asset_order.split(",")
    # assets of those ids, in the right order
  
  


=begin  
  
@usedsortedassets = 
@asset_orderids.sort do |e1, e2|
  if @allassets.index(e1) <=>  @allassets.index(e2) 
    @allassets.index(e1)
  else
   @allassets.index(e2)
  end
end
=end


a2=@allassets#["one", "two", "three"]
a1=@asset_orderids#["two", "one", "three"]

#a2.sort_by{|x| a1.index x.id}


#a1.each_with_index do |id, idx|
#  found_idx = aZ.find_index { |c| c.id == id }
#  replace_elem = a2[found_idx]
#  a2[found_idx] = a2[idx]
#  a2[idx] = replace_elem
#end  

@usedsortedassets = a2

#    @usedsortedassets = Asset.find(@asset_orderids)  

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
      redirect_to users_url

     else # you don
      flash[:success] = "Action Not Allowed by You"
      redirect_to root_url
   end
  end

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

  #render :text => order.inspect
end

 private 

    def gallery_params
      params.require(:gallery).permit(:title, {:asset_ids => []}, :asset_order, :friendly_name, :private)
    end
    
    def set_gallery
    @gallery = Gallery.find(params[:id])
  
  end
  
end
