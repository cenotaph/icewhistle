class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.2]
  def self.up
    add_column :users, :provider, :string, :null => false, :default => "email"
    add_column :users, :uid, :string, :null => false, :default => ""
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :allow_password_change, :boolean, :default => false
    add_column :users, :tokens, :text

    add_index :users, :email,                unique: true
    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,       unique: true
  end
end
