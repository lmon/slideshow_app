class CreateDefaultValuePrivateGallery < ActiveRecord::Migration
  def up
        change_column :galleries, :private, :boolean
    end
end
