require "bundler/setup"
require "database_cleaner/sequel"

if ENV['COVERAGE'] == 'true'
  require "simplecov"

  if ENV['CI'] == 'true'
    require 'codecov'
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
    puts "required codecov"
  end

  SimpleCov.start
  puts "required simplecov"
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
