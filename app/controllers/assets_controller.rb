class AssetsController < ApplicationController
 
  before_action :signed_in_user, only: [:create, :destroy, :update, :new, :edit]
  before_action :set_asset,     only: [:edit, :update, :show]
  # allows users to access these functions only for them elves
  before_action :correct_user,   only: [:edit, :update]

   def index
    if signed_in_as_admin_user?  # logged in as admin? show all
      @assets = Asset.paginate(page: params[:page])  # gets all assets  
     elsif signed_in?
      @assets = Asset.where("user_id = ?", current_user.id).paginate(page: params[:page])
     else
      redirect_to root_url
    end
end

def index_all
    if signed_in_as_admin_user?  # logged in as admin? show all
      @assets = Asset.includes(:user).paginate(page: params[:page])  # gets all assets  
      render 'index'
     else
      redirect_to root_url
    end
end

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
         #[TODO]
         flash[:success] = "Asset updated!"
         redirect_to @asset
      else
         flash.now[:error] = "You've got Issues."
         render 'edit'
      end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
      @asset = Asset.find(params[:id]) #.destroy()
      #flash[:success] = "Asset Deleted"
      #redirect_to all_assets_url
      @asset.destroy
      respond_to do |format|
      format.html
      format.js
      end
  end

	# POST /assets
  # POST /assets.json
    def create
    @asset = current_user.assets.build(asset_params)
    if @asset.save
         flash[:success] = "Asset created!"
         redirect_to all_assets_url #@asset
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
    params.require(:asset).permit(:name, :caption, :image)
  end

end
