class CreateUsers < ActiveRecord::Migration[5.2]
  # def change
  #   create_table :users do |t|

  #     t.timestamps
  #   end
  
  def up
    create_table :users do |t|

      # inside this do block, there will be column definitions
      # yields up the table as variable name |t| and then we apply columns to that table

      # rails will automatically add id to the table model and we dont need to mention it in the migrations.... if we dont want id in the schema then use `, :id => false` in the create_table definition

      # column definitions
      t.column "first_name", :string, :limit => 25
      # shorthand syntax for creating a column as inside this do block we're gonna define columns only
      t.string "last_name", :limit => 50
      t.string "email", :null => false
      t.string "password", :limit => 16

      t.timestamps
      # automatic populated by rails if these are the column names but t.timestamps does the same thing
      # t.datetime "created_at"
      # t.datetime "updated _at"
      
    end
  end

  def down 
    drop_table :users
  end

end
