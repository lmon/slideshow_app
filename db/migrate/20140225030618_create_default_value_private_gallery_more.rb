class CreateDefaultValuePrivateGalleryMore < ActiveRecord::Migration
  def up
        change_column :galleries, :private, :boolean, :default=>false
    end
end
