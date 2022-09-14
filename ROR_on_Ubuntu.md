```
rails new simple_cms -d mysql
```

## Problem of installing mysql2

solution :

---

## Installing on Ubuntu 20.04 VM

1. Opened terminal in the specified folder
2. Followed this https://www.itzgeek.com/post/how-to-install-ruby-on-rails-on-ubuntu-20-04/ till `gem install bundler` at the end of rbenv part.
3. Error at

```
$ bundle install
rbenv: version `ruby-2.7.0' is not installed
```

So solved it by

```
rbenv install 2.7.0
```

4. Got error on `bundle install`

```
An error occurred while installing mysql2 (0.5.4), and Bundler cannot
continue.
Make sure that `gem install mysql2 -v '0.5.4' --source 'https://rubygems.org/'`
succeeds before bundling.
```

tried

```
gem install mysql2 -v '0.5.4' --source 'https://rubygems.org/'
```

but no help.

**Solution** :
Missing dev library of mysql:

Step 1 :

```
sudo dpkg --configure -a
```

Step 2 :

```
sudo apt-get install libmysqlclient-dev
```

Then `bundle install`.

5. An error upon this command

```
$ mysql -u root -p

Command 'mysql' not found, but can be installed with:

sudo apt install mysql-client-core-8.0     # version 8.0.30-0ubuntu0.20.04.2, or
sudo apt install mariadb-client-core-10.3  # version 1:10.3.34-0ubuntu0.20.04.1
```

So ran the following

```
sudo apt install mysql-client-core-8.0
```

6. Was getting error upon `mysql -u root -p`

```
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysql.sock' (2)
```

So tried

1 - Update and Upgrade

```
sudo apt-get update
sudo apt-get upgrade
```

2 - Purge MySQL Server and Client (if installed).

```
sudo apt-get purge mysql-server mysql-client
```

3 - Install MySQL Server and Client fresh

```
sudo apt-get install mysql-server mysql-client
```

4 - Test MySQL

```
mysql -u root -p
```

If error comes Then

4 - Configure mysqld.cnf with nano of vi

```
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```

Change bind-address from 127.0.0.1 to localhost

```
bind-address            = localhost
```

`Ctrl` + `X` -> `Y` -> `Enter`

5 - Restart MySQL

```
sudo /etc/init.d/mysql restart
```

6 - Check it with sudo

```
sudo mysql -u root -p
```
