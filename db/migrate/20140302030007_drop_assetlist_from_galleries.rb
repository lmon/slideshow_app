class DropAssetlistFromGalleries < ActiveRecord::Migration
def change
    remove_column :galleries, :asset_list 
  end
end
