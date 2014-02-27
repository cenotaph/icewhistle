class AddSortorderToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :sortorder, :integer
  end

  def self.down
    remove_column :links, :sortorder
  end
end
