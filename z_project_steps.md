## After successfully installing ror and setting mysql on Ubuntu 20.04

Just fyi :
Rails version: 5.2.8.1
Ruby version: 2.7.0 (x86_64-linux)
MySQL Server version: 8.0.30-0ubuntu0.20.04.2 (Ubuntu)

#### V6

1.

```
sudo mysql -u root -page
```

2.

```
> CREATE DATABASE simple_cms_development;
```

3.

```
> CREATE DATABASE  CREATE DATABASE simple_cms_test;
```

4. Using root user to connect to DB with rails is not a good practise, socreating a new user.

```
> GRANT ALL PRIVILEGES ON simple_cms_development.* TO 'rails_user'@'localhost' IDENTIFIED BY 'secretpassword';
```

This above one was not working, so tried the following one

```
CREATE USER 'rails_user'@'localhost' IDENTIFIED BY 'secretpassword';
```

```
GRANT ALL PRIVILEGES ON simple_cms_development.* TO 'rails_user'@'localhost';
```

Means granting all privileges to all(\*) the tables of simple_cms_development DB to a rails_user which will be connecting locally and not from another IP address identifies with a password. Single quotes r imp.

5. Do same for test table

```
GRANT ALL PRIVILEGES ON simple_cms_test.* TO 'rails_user'@'localhost';
```

6.

```
exit
```

### Now database is connected to rails_user.

1. Go to config/database.yml
   1. Update the `username` and `password` with `rails_user` and `secretpassword` in the default section so that both of these DBs can log on to the MySQL.
2. **Checking the DB config we did** -> Dump the schema of DB into a file in db folder

```
rails db:schema:dump
```

But getting error

```
rails aborted!
ExecJS::RuntimeUnavailable: Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes.
```

So NodeJS is a JS runtime so will install it.

```
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
```

```
sudo apt install -y nodejs
```

Now it worked

```
rails db:schema:dump
```

---

#### V8

Start Web Server

```
rails server
```

or

```
rails s
```

---

#### V9

1. Generating a controller by `rails generate controller`
   1. Stubs out a new controller and its views. Pass the controller name, either
      CamelCased or under_scored, and a list of views as arguments.
2. ```
   rails generate controller demo index
   ```

```
Here, demo is the new controller and index is the new view
```

3. This created a new route so can check it via `https://localhost:3000/demo.index`.

So created a controller and view

#### V10

1. Learnt indepth architecture of MVC with web server into play
2. Where web server interacts with the `public` folder and if the requested content is not found then rails architecture handles it with controller and views and models.
3. Added `static_page.html` in `public` folder.
4. Attempted to access it via http://localhost:3000/static_page.html but notice there's no logging on the terminal of rails app as the html doc is in public folder so rails was never needed.
5. Now changed the path by adding the html doc to a new folder names demo. So the url changes to https://localhost:3000/demo/static_page
6. If added index.html in public then it'll be served first by the web server on the url https://localhost:3000/demo/index

---

#### V11 - Routing

1. If rails cant find a matching doc in the public folder then it send the request to the routing portion of the rails framework. Rails examines the url and determines which action and controller needs to be called.
2. Three Types : 
   1. Simple match route - `get 'demo/index'`
   2. Default route - `get ':controller(/:action(/:id))'`
   3. Root route - `oot 'demo#index'` Used to route if nothing is written after domain in url. When nothing is there to compare for routing.
   4. Resourcefull route
3. 
```
Started GET "/demo/index" for ::1 at 2022-09-14 19:07:12 +0530
Processing by DemoController#index as HTML
  Rendering demo/index.html.erb
  Rendered demo/index.html.erb (0.4ms)
Completed 200 OK in 2ms (Views: 1.0ms | ActiveRecord: 0.0ms)
```
Meaning successfully routed at `DemoController` and `index` action.
4. Default route structure :
```
:controller/:action/:id
```
Example a request for `GET/students/edit/52` means `StudentsController, edit action, id=52`.

5. If the rule of `get 'demo/index'` is removed from the `routes.rb` then the url wont work.
   1. But for this new default route `  get ':controller(/:action(/:id))'` it'll work.
   2. This will lead to a right match as the pattern in url will be compared like this and treated as controller/action accordingly. 
   3. But wont use it as it may go away in futuru rails versions.


---

#### V12

1. Created a controller with 2 actions via terminal.
```
rails generate controller example action1 action2
```
2. This resulted in new routes creation.
3. Tried URL http://localhost:3000/example/action2 


---

#### V13

1. Created `hello.html.erb` in app/views/demo.
2. Added a simple match route for it.
3. Adding an action for each template is a good practise
   1. Added `def hello` in the demo_controller. 
4. Added explicit render methods in the demo_controller.

---

#### V14 - Redirecting actions from the controller

1. HTTP Redirect - Server sends a redirect request to the browser agrees to the request and the browser then requests the page to the server to get redirected to that new page.
2. Addded `other_hello` action method in the demo_controller and in `routes.rb`

---

#### V15 - View templates (erb docs)

- erb stands for embedded ruby.

1. Wrote basic ruby in index view `index.html.erb`.

---

#### V16 - Instance variables

- Used to give our template access to data gathered by the controller
- Used to pass data from controller to the view

1. Added an instance variable in demo_controller.rb


---

#### V17 - Links

1. Rails will write for a `link_to` method inside a erb tag like `<%= %>` which = sign as it is going to output an `a href` html tag.
```
<%= link_to(text, target) %>
```
i.e. link text, link target

2. `target` can be a simple text `"/demo/index"` or a ruby hash `<%= link_to('A Ruby Hash link to Hello', {:action => 'hello'})%> `

---

#### V18 - URL Parameters

1. HTML link parameters start after `?` and are separated by `&`. `http://localhost:3000/demo/hello?id=20&page=5`
2. Rials has ability to specify values based on 'symbols' or 'strings' interchangably using `params`
3. Best place to add parameters to our link is to add them in the controller files.
4. Setting params as instance variable in controller will give us access to them in the template 
5. Trying to get the parameters from url into template elements in the hello template.
6.Learnt* : ALways render template at the end of action of method and after all the instance variables are defined.

---

#### V19 - INtro to DB :

1. Most models in rails will be connected to DB tables 
2. The process of defining models usually  starts with creating DB tables.

---

#### V20 - Create DB

1. Not a good practise to use DB via the root user but to add a new user and grant permissions to it.

---
#### V21 - Migrations

1. Will add tables in the DB by writing migrations in rails
2. Migration is a set of DB instructions written in ruby which migrate the DB state from one state to another. 
3. They describe DB changes
4. COntains instructions of moving up and down the states.
5. Maintains DB with application code
6. Allows sharing between multiple programmers for sync mainting the same state for collab.
7. Allows writing Ruby instead of SQL.
8. Repeatable as from one PC to another PC the DB can be re-created with same config with the help of migrations.

---

#### V22 - Generate migrations

1. Use CamelCase for the name
```
rails generate migration MigrationName
```
2. 
```
rails generate migration DoNothingYet
```
3. Name of the newly created migration will be started with a timestamp to keep uniqueness and sorting.  
4. Migrations will be referred by timestamps and not names
5. `up` & `down` methods in the migration file are mirror images of each other. If up is creating then down will be expected to delete.


---

#### V23 - Generate models

- When we generate a model, a migration file is generated along with it. 

1. Use CamelCase for the name
```
rails generate model SingularName
```
2. Creating one (write model name in singlular but rails will make table name as plural )
```
rails generate model User
```
3. Changinf the default `change` definition to up and down in `db/migrate/create_users.rb` file
4. MIgrations try to be data independence i.e if mysql used varchar for a column then other DB can be adapted with pther datatype as per the requirement. So in the migration code we can write column for a 'string' datatype and rails will handle what the DB is suitable for a string datatype.
5. Various datatypes used in rails for model definition :
   1. binary
   2. boolean 
   3. date
   4. datetime
   5. decimal
   6. float
   7. integer -> becomes int
   8. string -> translates to varchar for mysql
   9. text -> becomes string
   10. time
6. Commonly used are string, integer and boolean
7. Options for columns 
```
:limit => size of field/char/datatype

:default => value

:null => true/false

:precision => number

:scale => number

```
8. Rails will automatically add id to the table model and we dont need to mention it in the migrations.... if we dont want id in the schema then use `, :id => false` in the create_table definition


---

#### V24 : Run Migrations - in order for those changes to take effect

1. Following commmand is used where migrate task is done for db which will be targetting our development DB. This command will run all the migrations which have not been run

```
rails db:migrate
```

This command gave me errors as I had did typos in the migration file.

```
rails aborted!
SyntaxError: /home/meet/Desktop/ROR/simple_cms/db/migrate/20220917073114_create_users.rb:19: syntax error, unexpected '=', expecting `end'
... t.string "last_name", :limit =. 50
...                              ^
/home/meet/Desktop/ROR/simple_cms/db/migrate/20220917073114_create_users.rb:20: syntax error, unexpected '=', expecting `end'
      t.string "email", :null = false
                              ^
/home/meet/Desktop/ROR/simple_cms/db/migrate/20220917073114_create_users.rb:21: syntax error, unexpected '=', expecting `end'
...  t.string "password", :limit = 16
...                              ^
/home/meet/Desktop/ROR/simple_cms/db/migrate/20220917073114_create_users.rb:35: syntax error, unexpected `end', expecting end-of-input
/home/meet/Desktop/ROR/simple_cms/vendor/cache/ruby/2.7.0/gems/bootsnap-1.13.0/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:32:in `require'
/home/meet/Desktop/ROR/simple_cms/vendor/cache/ruby/2.7.0/gems/bootsnap-1.13.0/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:32:in `require'
```
Successfully migrated both `DoNothingYet` and `CreateUsers` with lots of warnings of deprecation.
2. Since rails v5, this rails was called `rake db:migrate`
3. LOg onto mysql
```
mysql -u rails_user -p simple_cms_development
```
4. 
```
mysql> SHOW TABLES;
+----------------------------------+
| Tables_in_simple_cms_development |
+----------------------------------+
| ar_internal_metadata             |
| schema_migrations                |
| users                            |
+----------------------------------+
3 rows in set (0.00 sec)
```

5. 
```
mysql> show fields from users;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | bigint       | NO   | PRI | NULL    | auto_increment |
| first_name | varchar(25)  | YES  |     | NULL    |                |
| last_name  | varchar(50)  | YES  |     | NULL    |                |
| email      | varchar(255) | NO   |     | NULL    |                |
| password   | varchar(16)  | YES  |     | NULL    |                |
| created_at | datetime     | NO   |     | NULL    |                |
| updated_at | datetime     | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)
```

6. 
```
mysql> show fields from schema_migrations;
+---------+--------------+------+-----+---------+-------+
| Field   | Type         | Null | Key | Default | Extra |
+---------+--------------+------+-----+---------+-------+
| version | varchar(255) | NO   | PRI | NULL    |       |
+---------+--------------+------+-----+---------+-------+
1 row in set (0.00 sec)
```

7. 
```
mysql> select * from schema_migrations;
+----------------+
| version        |
+----------------+
| 20220915171152 |
| 20220917073114 |
+----------------+
2 rows in set (0.00 sec)
```
The above shows the timestamps at which the migrations were created.
```
mysql> select * from users;
Empty set (0.00 sec)
```

8. Upon running migrations, the `schema.rb` file also gets updated.

9. To undo all the things done by `up` method, run the following to _**migrate down**_.
```
rails db:migrate VERSION=0
```
This will revert everything in the `schema.rb` file too and will make the version as 0.
Reverting is done in reverse order to undo things.
```
== 20220917073114 CreateUsers: reverting ======================================
-- drop_table(:users)
   -> 0.0173s
== 20220917073114 CreateUsers: reverted (0.0174s) =============================

== 20220915171152 DoNothingYet: reverting =====================================
== 20220915171152 DoNothingYet: reverted (0.0000s) ============================
```

10. Login back to mysql 
```
mysql -u rails_user -p simple_cms_development
```

11. Users table is gone now .
```
mysql> SHOW TABLES;
+----------------------------------+
| Tables_in_simple_cms_development |
+----------------------------------+
| ar_internal_metadata             |
| schema_migrations                |
+----------------------------------+
2 rows in set (0.00 sec)

mysql> select * from users;
ERROR 1146 (42S02): Table 'simple_cms_development.users' doesn't exist
```

12. To know the status of migrations
```
$ rails db:migrate:status

database: simple_cms_development

 Status   Migration ID    Migration Name
--------------------------------------------------
  down    20220915171152  Do nothing yet
  down    20220917073114  Create users
```

13. To run a specific migration, user their migration id.
```
rails db:migrate VERSION=20220915171152
```
and the status for it will become `up`.

14. _**Run Migrations**_

```
rails db:migrate
```
```
rails db:migrate VERSION=0
```
```
rails db:migrate VERSION=20161231235959
```
```
rails db:migrate:status
```

always provide version number if specifying up or down method.
```
rails db:migrate:up VERSION=20161231235959
```
```
rails db:migrate: down VERSION=20161231235959 
```
```
rails db:migrate: redo VERSION=20161231235959
```
redo  means doing a down and then quick up.

15. `rails db:migrate`

---

####  V24 - Migration Methods

1. Table Migration Methods
```
create_table(table, options) do |t| 
   ...columns... 
end
```
```
drop_table(table)
```
```
rename_table(table, new_name)
```

2. Column Migration Methods
```
add_column (table, column, type, options) 
```
```
remove_column (table, column) 
```
```
rename_column (table, column, new_name) 
```
```
change_column (table, column, type, options)
```

3. Index Migration Methods
```
add_index (table, column, options)
```

```
remove_index(table, column)
```

4. Index Migration Method Options

```
:unique => true/false
```

```
:name => "your_custom_name"
```

- Creating a new migration to alter users
```
rails generate migration AlterUsers
```

- `rails db:migrate` was getting several warnings with this like ```warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call```,  ```warning: The called method `new_column_definition' is defined here```, `The called method 'initialize' is defined here`, etc etc.
   - SO to solve it, first deleted the migration by `rails d migration AlterUsers` and then again generated it and tried running it, it ran successfully but with many deprecation warnings.
   - Ran it like 
   ```
   rails db:migrate VERSION=543587....
   ```
- tdown method of ALterUsers was not working so created a new migration called `DeletingBug` and pasted the down method's code in that migration file and it ran successfully upon running the `rails db:migrate` command.

---

#### V28 - Exercise 

1. Generate model which will generate migration file along with it. 
`
rails generate model Subject
`
`
rails generate model Page
`
`
rails generate model Section
`
2. Wrote code in their migration files and ran the command for up and down migrations.

---

####  V29 - `ActiveRecord` and `ActiveRelation`

-- They are part of the rails framework wwhich power up the models.


- `ActiveRecord` refers to rails implementation of active record pattern.
- The active record pattern allows us to manipulate and retrieve data as objects and not as static rows  
- `ActiveRecord` makes our object intelligent. These objects 
   - Understand the structure of DB table
   - Contain data from table rows
   - Has code and Knows how to CRUD rows using that code
   - THese objects can be manipulated and saved back to the DB with few simple commands

</br>

- `ActiveRelation` is also known is as 'ARel'.
- Object Oriented representation of relational algebra 
- Simplifies the generation of complex DB queries 
- Allows small queries are inter-linked chainable.
- Handles complex joins and aggregations and makes sure it uses efficient SQL.
- Handles timing of query execution. Queries are nnot executed untill needed.
- ARel is going to be used heavily by ActiveRecord for  queries for managing the the relationship amongst our objects. 
- ActiveRecord sits on top of ARel.
- ARel stays behind the scenes
- ActiveRelation Example
```
#simplified version using related ARel
users = User.where(:first_name => "Kevin") 
users = users.order("last_name ASC").limit (5)

#Translated complex SQL by rails
SELECT users.* FROM users
WHERE users.first_name = 'Kevin'
ORDER BY users.last_name ASC
LIMIT 5
```

---
####  V30 - Model Naming

1. `ApplicationRecord` is inherited from `ActiveRecord` and it'll have all code which is common to all the models.
2. `ActiveRecord::Base` is the core part of rails where we are adding behaviours to our class.
   1. So `user.rb` is able to do alot of things by using `ApplicationRecord` which is inherited from `ActiveRecord::Base`


--- 

#### V32 - Rials console 

1. `development` can be replaced by any of your environment like test/production
```
rails console development
```
The following assumes development environment by default
```
rails console
```
```
rails c
```

2. `irb` - interactive ruby console.
```
irb
```
O/p:
```
$ irb
irb(main):001:0> 1+1
=> 2
irb(main):002:0> "Hello".upcase
=> "HELLO"
irb(main):003:0> "Hello".upcase.reverse
=> "OLLEH"
irb(main):004:0> exit
```

3. Starting rails console, it'll start irb with rails environment and sources.
```
rails console
```

4. Can create new instance of a model class.
```
subject = SUbject.new
```
and play with it 
```
subject.name = "Test
```
```
subject.name
```
- BUt various warnings came too 
```
irb(main):001:0> subject = Subject.new
   (0.5ms)  SET NAMES utf8,  @@SESSION.sql_mode = CONCAT(CONCAT(@@sql_mode, ',STRICT_ALL_TABLES'), ',NO_AUTO_VALUE_ON_ZERO'),  @@SESSION.sql_auto_is_null = 0, @@SESSION.wait_timeout = 2147483
/home/meet/Desktop/ROR/simple_cms/vendor/cache/ruby/2.7.0/gems/activemodel-5.2.8.1/lib/active_model/type/integer.rb:13: warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
/home/meet/Desktop/ROR/simple_cms/vendor/cache/ruby/2.7.0/gems/activemodel-5.2.8.1/lib/active_model/type/value.rb:8: warning: The called method `initialize' is defined here

irb(main):002:0> subject.name = "Test"

irb(main):003:0> subject.name 
=> "Test"
```
It's a good way to test the model instead of bring controller, view into the picture to interact with the models.


---

####  V33 - Create records in DB

- 2 techniques 

1. new/save (3 step process)
   1. Instantiate object (create new object of the class or instance of the class) 
   2. Set values (on that instance)
   3. Save
2. `Create` - can do all above 3 steps in one line

~~~
~~~


1. Start rails console 
2. Create a new instance of the class `Subject`
```
subject = Subject.new
```

- `ActiveRecord` has number of methods to make these objects smart
1. `new_record?`
```
irb(main):003:0> subject.new_record?
=> true
```
returns true means it's not been saved to DB yet
2. Setting name 
```
irb(main):004:0> subject.name = "First name"
irb(main):005:0> subject.name
=> "First name"
```
but it isn't saved into the DB yet
3. Faster way to write the above in one command
```
Subject.new(:name => "FIrst name", :position => 1, :visible => true)
```
4. Still `subject.new_record?` is true so let's save it to DB.
```
subject.save
```
O/P:
```
(0.5ms)  BEGIN
  Subject Create (5.1ms)  INSERT INTO `subjects` (`name`, `position`, `visible`, `created_at`, `updated_at`) VALUES ('FIrst name', 1, TRUE, '2022-09-20 14:39:08', '2022-09-20 14:39:08')
   (5.4ms)  COMMIT
=> true
```
5. Now `subject.new_record?` is false as we saved the new record to DB.
6. `id` is the primary key which is auto assigned everytime. created_at and updated_at are also auto assigned.
```
irb(main):013:0> subject.id
=> 1
irb(main):014:0> subject.created_at
=> Tue, 20 Sep 2022 14:39:08 UTC +00:00
irb(main):015:0> subject.updated_at
=> Tue, 20 Sep 2022 14:39:08 UTC +00:00
```
7. This saving pattern is good for controllers as we can do like the following.
``` 
irb(main):016:1* if subject.save
irb(main):017:1*   puts "Saved"
irb(main):018:1* else
irb(main):019:1*   puts "NOt saved"
irb(main):020:0> end
   (0.4ms)  BEGIN
   (0.2ms)  COMMIT
Saved
=> nil
``` 
8. Creating another subject oject by overriding the other one.
```
subject = Subject.create(:name => "Second subject", :position => 2)
```
o/p:
```
(0.2ms)  BEGIN
  Subject Create (0.5ms)  INSERT INTO `subjects` (`name`, `position`, `created_at`, `updated_at`) VALUES ('Second subject', 2, '2022-09-20 14:47:48', '2022-09-20 14:47:48')
   (11.1ms)  COMMIT
```
9. new_record? was true so saved it by `subject.save`.


---

####  V34 - Update records 

- 2 Techniques 
   - Set the attributes at a time and then save
   - Set the attributes all at once and save

- Find/save technique
   1. Find record
   2. Set values
   3. Save

- Find/update_attributes
   1. Find record
   2. Set values and save both in one step

1. Find the record using id (overriding the previous subject object)
``` 
subject = Subject.find(1)
``` 
2. Updating name attribute
```
irb(main):032:0> subject.name = "Initial subject"
irb(main):033:0> subject.name
=> "Initial subject"
```
3. Save it.
```
subject.save
```
It gave ouput of Update SQL statement
```
(0.3ms)  BEGIN
  Subject Update (0.7ms)  UPDATE `subjects` SET `name` = 'Initial subject', `updated_at` = '2022-09-20 15:09:22' WHERE `subjects`.`id` = 1
   (9.8ms)  COMMIT
=> true
```
4. Updated_at time changes too.
```
irb(main):035:0> subject.created_at
=> Tue, 20 Sep 2022 14:39:08 UTC +00:00
irb(main):037:0> subject.updated_at
=> Tue, 20 Sep 2022 15:09:22 UTC +00:00
```

- - 2nd Technique 
1. Find record
```
subject = Subject.find(2)
```
2. Use the method update_attributes
```
subject.update_attributes(:name => "Next subject", :visible => true)
```