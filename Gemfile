# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'dry-auto_inject'
gem 'dry-container'
gem 'dry-schema'
gem 'dry-transaction'
gem 'grape'
gem 'grape-entity'
gem 'pg'
gem 'puma'
gem 'racksh', require: false
gem 'rake'
gem 'sequel'

group :development, :test do
  gem 'awesome_print'
  gem 'pry-byebug'
  gem 'rspec'
end

group :development do
  gem 'rerun'
  gem 'rubocop'
end

group :test do
  gem 'database_cleaner', require: false
  gem 'rack-test', require: false
end
