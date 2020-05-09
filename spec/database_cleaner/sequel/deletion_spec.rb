require 'database_cleaner/sequel/deletion'
require 'database_cleaner/spec'
require 'support/sequel_helper'

module DatabaseCleaner
  module Sequel
    RSpec.describe Deletion do
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

          context 'when several tables have data' do
            before do
              connection[:users].insert
              connection[:agents].insert
            end

            context 'by default' do
              it 'deletes all the tables' do
                subject.clean

                expect(connection[:users]).to be_empty
                expect(connection[:agents]).to be_empty
              end
            end
          end

          context 'with multiple databases' do
            it 'complains when you try to specify a default' do
              ::Sequel.connect("sqlite:/")
              subject.db = :default
              expect { subject.clean }.to raise_error("As you have more than one active sequel database you have to specify the one to use manually!")
            end
          end
        end
      end
    end
  end
end
