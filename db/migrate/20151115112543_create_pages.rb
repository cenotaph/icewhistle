class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.boolean :published
      t.string :image
      t.string :image_content_type
      t.integer :image_height
      t.integer :image_width
      t.integer :image_size, length: 8 
      t.string :slug 
      t.timestamps null: false
    end
  end
end
