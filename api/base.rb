# frozen_string_literal: true

require 'movies'
require 'bookings'

module CinemaBookingAPI
  class Base < Grape::API
    format :json

    helpers do
      def logger
        Logger.new "log/#{ENV['RACK_ENV']}.log"
      end
    end

    mount Movies
    mount Bookings
  end
end
