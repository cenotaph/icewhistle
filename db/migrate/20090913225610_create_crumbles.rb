class CreateCrumbles < ActiveRecord::Migration
  def self.up
    create_table :crumbles do |t|
      t.string :title
      t.integer :category
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size
      t.datetime :icon_updated_at
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :crumbles
  end
end
