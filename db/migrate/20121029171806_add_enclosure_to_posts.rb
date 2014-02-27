class AddEnclosureToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :enclosure_url, :string
  end
end
