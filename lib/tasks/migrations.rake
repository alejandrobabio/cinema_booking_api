# frozen_string_literal: true

# Migrate

migrate = lambda do |env, version|
  ENV['RACK_ENV'] = env
  require_relative '../../config/environment'
  require_relative '../cinema_booking/db'
  require 'logger'
  Sequel.extension :migration
  if CinemaBooking::DB.loggers.empty?
    CinemaBooking::DB.loggers << Logger.new($stdout)
  end
  Sequel::Migrator.apply(
    CinemaBooking::DB, "#{CinemaBooking::RootPath}/db/migrate", version
  )
end

desc 'Migrate test database to latest version'
task :test_up do
  migrate.call('test', nil)
end

desc 'Migrate test database all the way down'
task :test_down do
  migrate.call('test', 0)
end

desc 'Migrate test database all the way down and then back up'
task :test_bounce do
  migrate.call('test', 0)
  Sequel::Migrator.apply(
    CinemaBooking::DB, "#{CinemaBooking::RootPath}/db/migrate"
  )
end

desc 'Migrate development database to latest version'
task :dev_up do
  migrate.call('development', nil)
end

desc 'Migrate development database to all the way down'
task :dev_down do
  migrate.call('development', 0)
end

desc 'Migrate development database all the way down and then back up'
task :dev_bounce do
  migrate.call('development', 0)
  Sequel::Migrator.apply(
    CinemaBooking::DB, "#{CinemaBooking::RootPath}/db/migrate"
  )
end

desc 'Migrate production database to latest version'
task :prod_up do
  migrate.call('production', nil)
end
