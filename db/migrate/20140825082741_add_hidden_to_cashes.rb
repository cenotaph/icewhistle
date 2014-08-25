class AddHiddenToCashes < ActiveRecord::Migration
  def change
    add_column :cashes, :hidden, :boolean, :null => false, :default => false
  end
end
