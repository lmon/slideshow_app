class CreateAssets < ActiveRecord::Migration
  def change
    #if ActiveRecord::Base.connection.table_exists? :assets
    #drop_table :assets
	#end

	create_table :assets do |t|
      t.string :name
      t.string :caption

t.has_attached_file :image

      t.timestamps
    end
  end
end
