class AssetsController < ApplicationController
 
  before_action :signed_in_user, only: [:create, :destroy, :update, :new, :edit]

 # GET /assets
  # GET /assets.json
  def index
    if signed_in_as_admin_user?  # logged in as admin? show all
      @assets = Asset.paginate(page: params[:page])  # gets all assets  
     elsif signed_in?
      @assets = Asset.where("user_id = ?", current_user.id).paginate(page: params[:page])#current_user.feed.paginate(page: params[:page])
    else
      redirect_to root_url
    end
end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @asset = Asset.find(params[:id])
  end

  # GET /assets/new
  def new
    @asset = Asset.new
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

def update
    respond_to do |format|
      if @asset.update(user_params)
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
     Asset.find(params[:id]).destroy()
      flash[:success] = "Asset Removed"
      redirect_to users_url
    #@asset.destroy
    #respond_to do |format|
    #  format.html { redirect_to assets_url }
    #  format.json { head :no_content }
    #end
  end

	# POST /assets
  # POST /assets.json
    def create
    @asset = current_user.assets.build(asset_params)
    if @asset.save
         flash[:success] = "Asset created!"
         redirect_to @asset
         #format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @asset }
    else
        render 'new'
        #format.html { render action: 'new' }
        #format.json { render json: @asset.errors, status: :unprocessable_entity }
    end
  end
  


private
  def asset_params
   # params[:asset][:galleries] ||= []
    params.require(:asset).permit(:name, :caption, :image)
  end

end
