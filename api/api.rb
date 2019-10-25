# frozen_string_literal: true

require 'movies'
require 'bookings'

module CinemaBooking
  class API < Grape::API
    format :json

    helpers do
      def logger
        CinemaBooking::Logger
      end
    end

    mount Movies
    mount Bookings
  end
end
