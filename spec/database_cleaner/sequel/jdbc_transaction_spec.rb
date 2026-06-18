require 'database_cleaner/sequel/transaction'
require 'database_cleaner/spec'
require 'sequel'
require 'database_cleaner/spec/database_helper'
require 'ostruct'

if RUBY_PLATFORM == 'java'
  require_relative '../../support/postgresql-42.3.0.jar'

  class SequelHelper < DatabaseCleaner::Spec::DatabaseHelper
    private

    def establish_connection(_config = default_config)
      @connection = ::Sequel.connect(
        # 'postgres://database_cleaner:database_cleaner@127.0.0.1:5433/database_cleaner_test'
        'jdbc:postgresql://127.0.0.1:5433/database_cleaner_test?user=database_cleaner&password=database_cleaner'
      )
    end
  end
end

module DatabaseCleaner
  module Sequel
    RSpec.describe Transaction, :with_jdbc do
      it_should_behave_like "a database_cleaner strategy"

      SequelHelper.with_all_dbs do |helper|
        next unless helper.db == :postgres

        context "using a #{helper.db} connection" do
          around do |example|
            helper.setup
            example.run
            helper.teardown
          end

          let(:connection) { helper.connection }

          before { subject.db = connection }

          context "cleaning" do
            it "should clean database" do
              subject.cleaning do
                connection[:users].insert
                expect(connection[:users].count).to eq(1)
              end

              expect(connection[:users]).to be_empty
            end

            it "should work with nested transaction" do
              subject.cleaning do
                begin
                  connection.transaction do
                    connection[:users].insert
                    connection[:users].insert

                    expect(connection[:users].count).to eq(2)
                    raise ::Sequel::Rollback
                  end
                rescue
                end

                connection[:users].insert
                expect(connection[:users].count).to eq(1)
              end

              expect(connection[:users]).to be_empty
            end
          end

          context "start/clean" do
            it "should clean database" do
              subject.start

              connection[:users].insert
              expect(connection[:users].count).to eq(1)

              subject.clean

              expect(connection[:users]).to be_empty
            end

            it "should work with nested transaction" do
              subject.start
              begin
                connection.transaction do
                  connection[:users].insert
                  connection[:users].insert

                  expect(connection[:users].count).to eq(2)
                  raise ::Sequel::Rollback
                end
              rescue
              end

              connection[:users].insert
              expect(connection[:users].count).to eq(1)

              subject.clean

              expect(connection[:users]).to be_empty
            end
          end
        end
      end

      describe "start" do
        it "should start a transaction"
      end

      describe "clean" do
        it "should finish a transaction"
      end
    end
  end
end
