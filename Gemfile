source "https://rubygems.org"

# Specify your gem's dependencies in database_cleaner-sequel.gemspec
gemspec

gem "database_cleaner-core", git: "https://github.com/DatabaseCleaner/database_cleaner"

group :cruby_only do
  gem "byebug"
  gem "mysql2"
  gem "pg"
  gem "sqlite3"
end

group :development do
  gem "bundler"
  gem "rake"
  gem "rspec"
end

group :test do
  gem "simplecov", require: false
  gem "codecov", require: false
end
