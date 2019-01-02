class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.float :latitude, :decimal, {:precision=>10, :scale=>6}
      t.float :longitude, :decimal, {:precision=>10, :scale=>6}
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.string :slug
      t.text :link1
      t.text :link2
      t.datetime :expires
      t.boolean :registration

      t.timestamps
    end
  end
end
