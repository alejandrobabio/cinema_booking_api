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
        Repositories::Bookings.new(DB[:bookings])
      end
    end

    namespace :create_movie do
      register :validate do
        lambda do |args|
          require 'services/create_movie/validate'
          Services::CreateMovie::Validate.new.(args)
        end
      end

      register :persist do
        lambda do |args|
          require 'services/create_movie/persist'
          Services::CreateMovie::Persist.new.(args)
        end
      end
    end
  end
end
