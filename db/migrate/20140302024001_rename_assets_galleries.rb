class RenameAssetsGalleries < ActiveRecord::Migration

  def change
    if ActiveRecord::Base.connection.table_exists? :galleries_assets
    drop_table :galleries_assets
	end

    create_table :assets_galleries do |t|
      t.belongs_to :gallery
      t.belongs_to :asset
    end
    add_index :assets_galleries, [:gallery_id, :asset_id]

  end
end 

