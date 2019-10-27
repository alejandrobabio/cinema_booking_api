# frozen_string_literal: true

require 'bookings/create'

module CinemaBooking
  class Bookings < Grape::API
    namespace :bookings do
      mount Create
    end
  end
end
