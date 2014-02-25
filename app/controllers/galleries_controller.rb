class GalleriesController < ApplicationController

def index
    # i assume this can only be used if the display is paginated?
    @galleries = Gallery.paginate(page: params[:page])
  end

  def new
  	@gallery = Gallery.new
  end

  def show
  	@gallery = Gallery.find(params[:id])
  end

  def create
end

def edit

  end

  def update
  	end

def destroy
end

end
