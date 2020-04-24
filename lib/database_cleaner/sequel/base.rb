require "database_cleaner/strategy"

module DatabaseCleaner
  module Sequel
    class Base < Strategy
      def db
        return @db if @db && @db != :default
        raise "As you have more than one active sequel database you have to specify the one to use manually!" if ::Sequel::DATABASES.count > 1
        ::Sequel::DATABASES.first || :default
      end
    end
  end
end
