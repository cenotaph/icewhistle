class MakeCommentsPolymorphic < ActiveRecord::Migration
  def self.up
    rename_column :comments, :post_id, :item_id
    add_column :comments, :item_type, :string
    execute('UPDATE comments SET item_type = "Post"')
  end

  def self.down
    remove_column :comments, :item_type
    rename_column :comments, :item_id, :post_id
  end
end
