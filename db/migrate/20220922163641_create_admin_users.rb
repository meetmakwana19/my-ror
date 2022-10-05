class CreateAdminUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :admin_users do |t|
      t.column "first_name", :string, :limit => 25
      # t.string "first_name"
      t.string "last_name", :limit => 50
      t.string "username", :limit => 25
      t.string "email", :limit => 100
      t.timestamps
    end
  end
  
  def down 
    drop_table :admin_users
  end
  
end
