# frozen_string_literal: true

module CinemaBooking
  RootPath = File.expand_path('../', __dir__)

  Logger = Logger.new "log/#{ENV['RACK_ENV']}.log"
end
