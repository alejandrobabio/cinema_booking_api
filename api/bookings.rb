# frozen_string_literal: true

require 'bookings/create'
require 'bookings/index'

module CinemaBooking
  class Bookings < Grape::API
    namespace :bookings do
      mount Create
      mount Index
    end
  end
end
