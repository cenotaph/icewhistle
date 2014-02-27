class ConvertCrumblesToCw < ActiveRecord::Migration
  def self.up
    add_column :crumbles, :slug, :string
    add_index :crumbles, :slug, :unique => true
    rename_column :crumbles, :attachment_file_name, :attachment
    rename_column :crumbles, :icon_file_name, :icon
  end

  def self.down
    rename_column :crumbles, :attachment, :attachment_file_name
    rename_column :crumbles, :icon_file_name, :icon
    drop_column :crumbles, :slug    
  end
end
