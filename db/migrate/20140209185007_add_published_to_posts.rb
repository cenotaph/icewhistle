class AddPublishedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :published, :boolean, :null => false
    add_column :posts, :image, :string
    add_column :posts, :image_size, :integer, length: 8
    add_column :posts, :image_content_type, :string
    add_column :posts, :image_width, :integer
    add_column :posts, :image_height, :integer
    execute('update posts set published = true')
  end
end
