# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)

require 'database_cleaner'

Dir[File.expand_path('support', __dir__) + '/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
