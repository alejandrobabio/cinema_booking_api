# frozen_string_literal: true

require 'cinema_booking'
require 'cinema_booking/repositories/movies'

module CinemaBooking
  class Container
    extend Dry::Container::Mixin

    namespace :repositories do
      register :movies do
        Repositories::Movies.new(DB[:movies])
      end
    end
  end
end
