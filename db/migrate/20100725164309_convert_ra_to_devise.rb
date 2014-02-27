class ConvertRaToDevise < ActiveRecord::Migration
  def self.up
    
    #encrypting passwords and authentication related fields
    rename_column :users, "crypted_password", "encrypted_password"
    change_column :users, "encrypted_password", :string, :limit => 128, :default => "", :null => false
    rename_column :users, "salt", "password_salt"
    change_column :users, "password_salt", :string, :default => "", :null => false
    
    #confirmation related fields
    add_column :users, "confirmation_token", :string
    add_column :users, "confirmed_at", :string
    add_column :users, "confirmation_sent_at", :datetime
    rename_column :users, "login", "username"
    #reset password related fields
    add_column :users,  "reset_password_token", :string
    
    #rememberme related fields
    add_column :users, "remember_created_at", :datetime #additional field required for devise.
  
  end

  def self.down
    
    #rememberme related fields
    remove_column :users, "remember_created_at"
    rename_column :users, :username, :login
    #reset password related fields
    remove_column :users, "reset_password_token"
    
    #confirmation related fields
    remove_column :users, "confirmation_token"
    remove_column :users, "confirmed_at"

    remove_column :users, "confirmation_sent_at"

    #encrypting passwords and authentication related fields
    rename_column :users, "encrypted_password", "crypted_password"
    change_column :users, "crypted_password", :string, :limit => 40
    rename_column :users, "password_salt", "salt" 
    change_column :users, "salt", :string, :limit => 40
    
  end
end