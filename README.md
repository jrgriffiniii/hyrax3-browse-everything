# Hyrax Development Environment for browse-everything

## Getting Started

### Installing the Dependencies
```
bundle install
```

### Starting the Servers
```
bundle exec rake server:development
bundle exec rails s -p 3000
```

### Initializing Hyrax
```
bundle exec rails hyrax:default_admin_set:create
bundle exec rails generate hyrax:work MyWork
```

### Creating an Admin. User

First, please visit [http://localhost:3000/users/sign_up] and sign up for a new
user account. Then please install `hydra-role-management` with the following
steps:

Firstly, please stop the Rails server in the terminal running `bundle exec rails s -p 3000`.

Then, please add the following to your application's Gemfile:

```
gem 'hydra-role-management'
```

Then install the gem and run its database migrations:

```
bundle install
bundle exec rails generate roles
bundle exec rails db:migrate
```

Finally, create the new `admin` role and assign it to your user with the
following:

```
bundle exec rails c
:001 > u = User.last
:002 > u.roles << Role.first_or_create(name: 'admin') unless u.admin?
```

Now one can restart the Rails server:

```
bundle exec rails s -p 3000
```

### Creating a New Work

After logging in with [http://localhost:3000/users/sign_in], please visit [http://localhost:3000/concern/my_works/new] and complete the ingest form.

