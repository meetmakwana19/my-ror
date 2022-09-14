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