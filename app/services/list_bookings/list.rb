# frozen_string_literal: true

require 'dry/transaction/operation'

module CinemaBooking
  module Services
    class ListBookings
      class List
        include Dry::Transaction::Operation
        include Import['repositories.bookings']

        def call(params)
          Success(
            bookings.list_between_dates(params[:from], params[:to])
          )
        end
      end
    end
  end
end
