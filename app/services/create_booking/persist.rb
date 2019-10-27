# frozen_string_literal: true

require 'dry/transaction/operation'

module CinemaBooking
  module Services
    class CreateBooking
      class Persist
        include Dry::Transaction::Operation
        include Import['repositories.bookings']

        def call(params)
          bookings.create(params)
          Success()
        end
      end
    end
  end
end
