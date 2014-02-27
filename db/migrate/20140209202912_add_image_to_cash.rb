class AddImageToCash < ActiveRecord::Migration
  def change
    add_column :cashes, :image, :string
    add_column :cashes, :image_size, :integer, length: 8
    add_column :cashes, :image_width, :integer
    add_column :cashes, :image_height, :integer
    add_column :cashes, :image_content_type, :string
  end
end
