class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :filename
      t.integer :filename_width
      t.integer :filename_height
      t.string :filename_content_type
      t.integer :filename_size, length: 8
      t.string :item_type
      t.integer :item_id
      t.string :title
      t.text :caption

      t.timestamps
    end
    add_index :photos, [:item_type, :item_id]    
  end
end
