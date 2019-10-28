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
        rescue Sequel::UniqueConstraintViolation
          Failure(
            base: [
              message(params)
            ]
          )
        end

        private

        def message(params)
          result = <<~ERROR
            Booking Date: #{params[:booking_date]},
            Movie id: #{params[:movie_id]},
            Customer Name: #{params[:customer_name]}:
            combination already exists
          ERROR
          result.gsub("\n", ' ').strip
        end
      end
    end
  end
end
