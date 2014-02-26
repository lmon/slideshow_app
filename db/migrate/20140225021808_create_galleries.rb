class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.integer :user_id
      t.string :asset_order
      t.integer :private, :default=>1
      t.string :asset_list
      t.string :freindly_name

      t.timestamps
    end
    add_index :galleries, [:user_id, :created_at]
  end
end
