# frozen_string_literal: true

require 'entities/movie'

module CinemaBooking
  module Entities
    class Booking < Grape::Entity
      expose :id
      expose :booking_date
      expose :customer_name
      expose :movie, using: Movie
    end
  end
end
