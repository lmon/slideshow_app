class AddAssetsGalleriesRelationship < ActiveRecord::Migration
# from http://guides.rubyonrails.org/association_basics.html
# using 2.6 The has_and_belongs_to_many Association

  def change
    #create_table :assemblies do |t|
    #  t.string :name
    #  t.timestamps
    #end
 
    #create_table :parts do |t|
    #  t.string :part_number
    #  t.timestamps
    #end
 
    create_table :galleries_assets do |t|
      t.belongs_to :gallery
      t.belongs_to :asset
    end
    add_index :galleries_assets, [:gallery_id, :asset_id]

  end
end 
