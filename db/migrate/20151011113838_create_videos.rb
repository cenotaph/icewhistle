class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :item_type
      t.integer :item_id
      t.timestamps null: false
    end
  end
end
