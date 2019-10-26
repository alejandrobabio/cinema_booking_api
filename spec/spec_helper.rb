# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require File.expand_path('../config/environment', __dir__)

Dir[File.expand_path('support', __dir__) + '/**/*.rb'].each { |f| require f }
