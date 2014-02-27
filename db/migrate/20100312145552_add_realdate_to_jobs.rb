class AddRealdateToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :realdate, :datetime
  end

  def self.down
    remove_column :jobs, :realdate
  end
end
