require 'rake'
require 'sequel'

require_relative 'db/database'

MIGRATIONS_DIR = 'db/migrations'.freeze

namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate do
    Sequel.extension :migration
    version = ENV['VERSION'] ? ENV['VERSION'].to_i : nil
    Sequel::Migrator.run(DB, MIGRATIONS_DIR, target: version)
    puts "Migrations are up to date"
  end

  desc "Create the database"
  task :create do
    puts "Database created"
  end

  desc "Drop the database (DANGEROUS)"
  task :drop do
    db_file = 'db/dev_database.sqlite'
    if File.exist?(db_file)
      File.delete(db_file)
      puts "Database dropped"
    else
      puts "Database file not found"
    end
  end
end

desc "Runs the migrations up to the latest (use VERSION=x to migrate to a specific version)"
task :migrate => ['db:migrate']

desc "Create the database"
task :create => ['db:create']

desc "Drop the database (DANGEROUS)"
task :drop => ['db:drop']
