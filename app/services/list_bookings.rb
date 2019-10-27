# frozen_string_literal: true

require 'dry/transaction'

module CinemaBooking
  module Services
    class ListBookings
      include Dry::Transaction(container: Container)

      step :validate, with: 'list_bookings.validate'
      step :list,     with: 'list_bookings.list'
    end
  end
end
