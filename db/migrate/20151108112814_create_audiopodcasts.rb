class CreateAudiopodcasts < ActiveRecord::Migration
  def change
    create_table :audiopodcasts do |t|
      t.string :url
      t.references :item, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
