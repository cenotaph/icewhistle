class AddExtraAttributes < ActiveRecord::Migration
  def change
    add_column :videos, :bytes, :integer, length: 8
    add_column :audiopodcasts, :bytes, :integer, length: 8
    add_column :videos, :content_type, :string
    add_column :audiopodcasts, :content_type, :string
  end
end
