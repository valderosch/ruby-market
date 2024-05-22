require 'active_record'
require 'yaml'

db_config = YAML.load_file('RubyForms/bin/bot/database.yml')
ActiveRecord::Base.establish_connection(db_config['development'])

namespace :db do
  desc 'Migrate the database through scripts in db/migrate'
  task :migrate do
    ActiveRecord::Migrator.migrations_paths = ['db/migrate']
    ActiveRecord::MigrationContext.new('db/migrate').migrate
  end

  desc 'Create the database'
  task :create do
    ActiveRecord::Base.establish_connection(db_config['development'].merge('database' => nil))
    ActiveRecord::Base.connection.create_database(db_config['development']['database'])
  end

  desc 'Drop the database'
  task :drop do
    ActiveRecord::Base.establish_connection(db_config['development'].merge('database' => nil))
    ActiveRecord::Base.connection.drop_database(db_config['development']['database'])
  end

  desc 'Reset the database'
  task :reset => [:drop, :create, :migrate]
end
