class AddDatestampToCrumbles < ActiveRecord::Migration
  def self.up
    add_column :crumbles, :datestamp, :date
  end

  def self.down
    remove_column :crumbles, :datestamp
  end
end
