class DeletingBug < ActiveRecord::Migration[5.2]
  def change
    remove_index("admin_users", "username")
    
    rename_column("admin_users", "hashed_password", "password")
    
    change_column("admin_users", "email", :string, :null => false)
    
    remove_column("admin_users", "username") 
    
    rename_table("admin_users", "users")
  end
end
