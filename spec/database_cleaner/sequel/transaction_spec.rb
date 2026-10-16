require 'database_cleaner/sequel/transaction'
require 'database_cleaner/spec'
require 'support/sequel_helper'

module DatabaseCleaner
  module Sequel
    RSpec.shared_examples "cleaning" do
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

    RSpec.describe Transaction do
      it_should_behave_like "a database_cleaner strategy"

      SequelHelper.with_all_dbs do |helper|
        context "using a #{helper.db} connection" do
          around do |example|
            helper.setup
            example.run
            helper.teardown
          end

          let(:connection) { helper.connection }

          before { subject.db = connection }

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

          context "fiber concurrency" do
            # Making stub on the current implementation of the Sequel extension :fiber_concurrency.
            before do
              allow(::Sequel).to receive(:current).and_return(Fiber.current)
            end

            it "should use fibers" do
              expect(::Sequel.current).to be_a(Fiber)
            end

            it_should_behave_like "cleaning"
          end

          context "tread concurrency" do
            it_should_behave_like "cleaning"
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
