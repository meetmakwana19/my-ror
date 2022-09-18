class User < ApplicationRecord

    # if the name of DB is changed from User then rails wont be able to find it via this class due to naming convention
    # So we can explicitly define the DB
    # we can even rename this class and file 
    self.table_name = "admin_users"
end
