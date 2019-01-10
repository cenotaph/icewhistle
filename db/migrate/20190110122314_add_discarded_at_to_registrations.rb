class AddDiscardedAtToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :discarded_at, :datetime
    add_index :registrations, :discarded_at
  end
end
