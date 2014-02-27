class AddEnclosuresToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :enclosure_type, :string
    add_column :posts, :enclosure_length, :bigint
  end
end
