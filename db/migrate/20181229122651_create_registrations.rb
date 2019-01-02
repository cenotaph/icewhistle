class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.references :event, foreign_key: true
      t.string :email
      t.string :name
      t.string :phone
      t.text :question1
      t.text :question2
      t.text :question3
      t.string :website
      t.boolean :waiting_list
      t.text :comments

      t.timestamps
    end
  end
end
