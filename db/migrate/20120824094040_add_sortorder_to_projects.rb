class AddSortorderToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :sortorder, :float
    add_column :publications, :sortorder, :float
    add_column :jobs, :sortorder, :float
  end
end
