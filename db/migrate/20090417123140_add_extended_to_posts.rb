class AddExtendedToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :extended, :text
  end

  def self.down
    remove_column :posts, :extended
  end
end
