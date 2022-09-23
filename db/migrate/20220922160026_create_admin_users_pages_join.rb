class CreateAdminUsersPagesJoin < ActiveRecord::Migration[5.2]
  def up
    # dont need id in the join table so turn it off
    # want to create this table for removed the word Join from the naming definition below.
    create_table :admin_users_pages, :id => false do |t|
      # 2 foreign keys
      t.integer "admin_user_id"
      t.integer "page_id"
    end

    # adding index to both of these foreign keys in the join table 
    add_index("admin_users_pages", ["admin_user_id", "page_id"])
  end
  def down
    drop_table :admin_users_pages 
  end
end
