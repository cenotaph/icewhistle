class AddPasswordToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :password, :string
  end
end
