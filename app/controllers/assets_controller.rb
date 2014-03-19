class AssetsController < ApplicationController
 
  before_action :signed_in_user, only: [:create, :destroy, :update, :new, :edit]
  before_action :set_asset,     only: [:edit, :update, :show]
  # allows users to access these functions only for them elves
  before_action :correct_user,   only: [:edit, :update]

 # GET /assets
  # GET /assets.json
  def index
    if signed_in_as_admin_user?  # logged in as admin? show all
      @assets = Asset.paginate(page: params[:page])  # gets all assets  
     elsif signed_in?
      @assets = Asset.where("user_id = ?", current_user.id).paginate(page: params[:page])
     else
      redirect_to root_url
    end
end

  # GET /assets/1
  # GET /assets/1.json
  def show
    #@asset = Asset.find(params[:id])
  end

  # GET /assets/new
  def new
    @asset = Asset.new
  end

  # GET /assets/1/edit
  def edit
    #@asset = Asset.find(params[:id])
  end

  def update
      if @asset.update_attributes(asset_params)
         flash[:success] = "Asset updated!"
         redirect_to @asset
      else
         render 'edit'
      end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
     Asset.find(params[:id]).destroy()
      flash[:success] = "Asset Deleted"
      redirect_to assets_url
  end

	# POST /assets
  # POST /assets.json
    def create
    @asset = current_user.assets.build(asset_params)
    if @asset.save
         flash[:success] = "Asset created!"
         redirect_to @asset
    else
        render 'new'
    end
  end
  


private
  def correct_user
    @user = User.find(@asset.user_id)
    redirect_to(root_url) unless current_user?(@user)
  end  

    def set_asset
       @asset = Asset.find(params[:id])
    end


  def asset_params
    #if params[:image].nil? # either im not uploading my image yet or i dont want to change it
    #params.require(:asset).permit(:name, :caption)
    #else
    params.require(:asset).permit(:name, :caption, :image)
    #end
  end

end
