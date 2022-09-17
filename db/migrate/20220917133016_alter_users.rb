class AlterUsers < ActiveRecord::Migration[5.2]

  # def change
  def up
    # rename_table("users", "admin_users")

    # adding a new column for username 
    add_column("admin_users", "username", :string, **:limit => 25, :after => "email") #after is a special option which may not work with other DBs.

    # changing limit for email
    change_column("admin_users", "email", :string, **:limit => 100)

    # renaming pw attribute
    rename_column("admin_users", "password", "hashed_password")

    # console log printing
    puts "***Adding an index***"
    add_index("admin_users", "username")
  end

  def down
    # just same steps as up method just in reverse order
    # this method was not working so created a new migration called `DeletingBug`
    
    remove_index("admin_users", "username")
    
    rename_column("admin_users", "hashed_password", "password")
    
    change_column("admin_users", "email", :string, :null => false)
    
    remove_column("admin_users", "username") 
    
    rename_table("admin_users", "users")
  end

end
