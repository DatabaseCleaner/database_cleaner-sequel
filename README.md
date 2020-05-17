# Database Cleaner Adapter for Sequel

[![Build Status](https://travis-ci.org/DatabaseCleaner/database_cleaner-sequel.svg?branch=master)](https://travis-ci.org/DatabaseCleaner/database_cleaner-sequel)
[![Code Climate](https://codeclimate.com/github/DatabaseCleaner/database_cleaner-sequel/badges/gpa.svg)](https://codeclimate.com/github/DatabaseCleaner/database_cleaner-sequel)
[![codecov](https://codecov.io/gh/DatabaseCleaner/database_cleaner-sequel/branch/master/graph/badge.svg)](https://codecov.io/gh/DatabaseCleaner/database_cleaner-sequel)

Clean your Sequel databases with Database Cleaner.

See https://github.com/DatabaseCleaner/database_cleaner for more information.

## Installation

```ruby
# Gemfile
group :test do
  gem 'database_cleaner-sequel'
end
```

```ruby
# test_helper.rb
DatabaseCleaner[:sequel].strategy = :transaction

class Minitest::Spec
  before :each do
    DatabaseCleaner[:sequel].start
  end

  after :each do
    DatabaseCleaner[:sequel].clean
  end
end
```

## Supported Strategies

Three strategies are supported:

* Transaction (default)
* Truncation
* Deletion

## Strategy configuration options

The transaction strategy accepts no options.

The truncation and deletion strategies may accept the following options:

* `:only` and `:except` may take a list of collection names:

```ruby
# Only truncate the "users" table.
DatabaseCleaner[:sequel].strategy = :truncation, { only: ["users"] }

# Delete all tables except the "users" table.
DatabaseCleaner[:sequel].strategy = :deletion, { except: ["users"] }
```

* `:pre_count` - When set to `true`, this will check each table for existing rows before truncating or deleting it. This can speed up test suites when many of the tables are never populated. Defaults to `false`.

## Adapter configuration options

`#db` defaults to the default Sequel database, but can be specified manually in a few ways:

```ruby
# Sequel connection object
DatabaseCleaner[:sequel].db = Sequel.connect(uri)

# Back to default:
DatabaseCleaner[:sequel].db = :default

# Multiple Sequel databases can be specified:
DatabaseCleaner[:sequel, connection: :default]
DatabaseCleaner[:sequel, connection: Sequel.connect(uri)]
```
## COPYRIGHT

See [LICENSE](LICENSE) for details.
