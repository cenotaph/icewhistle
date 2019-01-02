class AddExtradateToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :extra_date, :string
  end
end
