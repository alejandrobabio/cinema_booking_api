# frozen_string_literal: true

require 'sequel/core'
require 'yaml'
require 'cinema_booking'

module CinemaBooking
  DB_CONFIG =
    if ENV['RACK_ENV'] == 'production'
      ENV.delete('DATABASE_URL')
    else
      YAML.safe_load(
        File.read("#{RootPath}/config/database.yml")
      )[ENV['RACK_ENV']]
    end.freeze
  private_constant :DB_CONFIG

  DB = Sequel.connect(DB_CONFIG['url'])
end
