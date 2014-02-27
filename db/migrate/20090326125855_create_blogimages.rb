class CreateBlogimages < ActiveRecord::Migration
  def self.up
    create_table :blogimages do |t|
      t.string :name
      t.string :filename

      t.timestamps
    end
  end

  def self.down
    drop_table :blogimages
  end
end
