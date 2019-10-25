# frozen_string_literal: true

require 'db_helper'

require 'rack/test'

RSpec.configure do |config|
  config.include(Rack::Test::Methods, type: :request)
end
