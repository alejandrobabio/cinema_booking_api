# frozen_string_literal: true

require 'cinema_booking/base_repository'

module CinemaBooking
  module Repositories
    class Bookings < BaseRepository
      def list_between_dates(from, to)
        result = dataset.where(booking_date: from..to).all
        preload(result, :movie_id, :movies)
      end
    end
  end
end
