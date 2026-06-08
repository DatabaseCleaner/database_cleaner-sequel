require 'sequel'
require 'database_cleaner/spec/database_helper'

class SequelHelper < DatabaseCleaner::Spec::DatabaseHelper
  class DatabaseShim
    def self.wrap(connection)
      if defined?(::Sequel::Trilogy::Database) && connection.is_a?(::Sequel::Trilogy::Database)
        TrilogyShim.new(connection)
      else
        new(connection)
      end
    end

    def initialize(connection)
      @connection = connection
    end

    def respond_to_missing?(method, include_private = false)
      @connection.respond_to?(method, include_private)
    end

    def unwrap
      @connection
    end

    private

    def method_missing(name, *args, &block)
      return super unless respond_to_missing?(name)

      @connection.send(name, *args, &block)
    end
  end

  class TrilogyShim < DatabaseShim
    def execute(sql)
      @connection.run(sql)
    end
  end

  private

  def establish_connection(config = default_config)
    url = "#{db}:///"
    url = "sqlite:///" if db == :sqlite3
    @connection = DatabaseShim.wrap(::Sequel.connect(url, config))
  end
end
