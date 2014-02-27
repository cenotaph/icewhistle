class AddIconToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :icon, :string
  end

  def self.down
    remove_column :publications, :icon
  end
end
