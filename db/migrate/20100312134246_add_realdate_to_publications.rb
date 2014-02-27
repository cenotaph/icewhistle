class AddRealdateToPublications < ActiveRecord::Migration
  def self.up
    add_column :publications, :realdate, :datetime
  end

  def self.down
    remove_column :publications, :realdate
  end
end
