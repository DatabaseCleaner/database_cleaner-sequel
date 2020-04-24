require 'database_cleaner/sequel'
require 'database_cleaner/spec'

RSpec.describe DatabaseCleaner::Sequel do
  it_should_behave_like "a database_cleaner adapter"
end
