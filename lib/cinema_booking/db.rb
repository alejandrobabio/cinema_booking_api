# frozen_string_literal: true

require 'sequel/core'
require 'yaml'
require 'cinema_booking'

module CinemaBooking
  DB_URL =
    if ENV['RACK_ENV'] == 'production'
      ENV.delete('DATABASE_URL')
    else
      YAML.safe_load(
        File.read("#{RootPath}/config/database.yml")
      )[ENV['RACK_ENV']]['url']
    end.freeze
  private_constant :DB_URL

  DB = Sequel.connect(DB_URL, logger: Logger)
end
