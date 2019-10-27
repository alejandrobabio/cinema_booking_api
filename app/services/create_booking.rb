# frozen_string_literal: true

require 'dry/transaction'

module CinemaBooking
  module Services
    class CreateBooking
      include Dry::Transaction(container: Container)

      step :validate, with: 'create_booking.validate'
      step :persist,  with: 'create_booking.persist'
    end
  end
end
