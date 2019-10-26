# frozen_string_literal: true

require 'cinema_booking'
require 'cinema_booking/repositories/movies'
require 'cinema_booking/repositories/bookings'

module CinemaBooking
  class Container
    extend Dry::Container::Mixin

    namespace :repositories do
      register :movies do
        Repositories::Movies.new(DB[:movies])
      end

      register :bookings do
        Repositories::Movies.new(DB[:bookings])
      end
    end
  end
end
