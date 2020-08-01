# Hyrax Development Environment for browse-everything

## Getting Started

### Installing the Dependencies
```
bundle install
```

### Starting the Servers and Migrating the Database
```
bundle exec rake server:development
bundle exec rails db:migrate
```

### Creating an Admin. User

First, please visit [http://localhost:3000/users/sign_up] and sign up for a new
user account. Then, create the new `admin` role and assign it to your user with 
the following:

```
bundle exec rails c
:001 > u = User.last
:002 > u.roles << Role.first_or_create(name: 'admin') unless u.admin?
```

### Initializing Hyrax
```
bundle exec rails hyrax:default_admin_set:create
```

Now one can start the Rails server:
```
DROPBOX_CLIENT_ID=client-id DROPBOX_CLIENT_SECRET=secret bundle exec rails s -p 3000
```

### Creating a New Work

After logging in with [http://localhost:3000/users/sign_in], please visit [http://localhost:3000/concern/my_works/new] and complete the ingest form.
