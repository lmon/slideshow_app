class RemoveFriendlyFromGallery < ActiveRecord::Migration
  change_table(:galleries) do |t|
  	t.remove :freindly_name
	end
end
