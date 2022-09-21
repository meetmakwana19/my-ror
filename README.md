# README


* Ruby version => ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux]
  
* Rails version => Rails 5.2.8.1

* MySQL version => 0.5.4

* Configuration => `rails new simple_cms -d mysql`

* Database creation => Refer `ROR_on_Ubunut.md`

---
---

# Some Rails concepts :

* 👉🏻 Start Web Server

```
rails server
```

or

```
rails s
```

* MVC Architecture
  
### 👉🏻 Controller :

* Handles interaction b/w views and browser with the help of `ACTION` methods.
* Handles routing
1. Created a controller with 2 actions via terminal.
```
rails generate controller example action1 action2
```
2. This resulted in new routes creation.

### 👉🏻 Instance variables

- Used to give our template access to data gathered by the controller
- Used to pass data from controller to the view

### 👉🏻 Migrations

1. Will add tables in the DB by writing migrations in rails
2. Migration is a set of DB instructions written in ruby which migrate the DB state from one state to another. 
3. They describe DB changes
4. COntains instructions of moving up and down the states.
5. Maintains DB with application code
6. Allows sharing between multiple programmers for sync mainting the same state for collab.
7. Allows writing Ruby instead of SQL.
8. Repeatable as from one PC to another PC the DB can be re-created with same config with the help of migrations.
9. Use CamelCase for the name
```
rails generate migration MigrationName
```
10. `up` & `down` methods in the migration file are mirror images of each other. If up is creating then down will be expected to delete.
11. Migrations try to be data independence i.e if mysql used varchar for a column then other DB can be adapted with pther datatype as per the requirement. So in the migration code we can write column for a 'string' datatype and rails will handle what the DB is suitable for a string datatype.

### Run Migrations - in order for those changes to take effect

1. Following commmand is used where migrate task is done for db which will be targetting our development DB. This command will run all the migrations which have not been run

```
rails db:migrate
```

2. Log onto mysql to  check if the migration created the tabkes in DB or not.
```
mysql -u rails_user -p simple_cms_development
```

### 👉🏻 Models

- When we generate a model, a migration file is generated along with it. 

1. Use CamelCase for the name (write model name in singlular but rails will make table name as plural )
```
rails generate model SingularName
```

_**Run Migrations**_

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


_**Migration Methods**_

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

### 👉🏻 `ActiveRecord` and `ActiveRelation`

-- They are part of the rails framework wwhich power up the models.

👉🏻 `ActiveRecord`

* The active record pattern allows us to manipulate and retrieve data as objects and not as static rows  
* Has many methods to perform CRUD operations on the DB without writing complex SQL but just by using it's methods in ruby.
* ActiveRecord provides "Association" which allows to define these resltionhips of 1:1, 1:m, n:m.
  

👉🏻 `ActiveRelation`

* Also known is as 'ARel'.
* Handles complex joins and aggregations and makes sure it uses efficient SQL.
* Rel is going to be used heavily by ActiveRecord for  queries for managing the the relationship amongst our objects. 
- `ActiveRecord` sits on top of ARel.
- ARel stays behind the scenes
- `ActiveRelation` will take all the things we've asked for and try to compile them into one query 

### 👉🏻 Rials console 

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

### 👉🏻 Named scopes

- We've been using the buit-in methods for free provided by ActiveRecord and ActiveRelation inherited from ActiveRecordBase for CRUD, finding, and other tasks.
- We can build our own query combined with the built-in methods and save it in our model as **Named scope**.
- **A good way to take alot of complex logic for query and store in a model to call it again as a method**
- 1. Named scope assign a name to an ActiveRelation query and save it in the model.
2. Accepts parameters
3. Rails 5 requires **lambda syntax** 
4. Naming a scope :
   1. active is the name of the scope, lambda can be also written with -> and where is the normal built-in query method.
   ```
   scope :active, lambda {where(: active => true)}

   scope :active, -> {where(:active => true)}

   ```
