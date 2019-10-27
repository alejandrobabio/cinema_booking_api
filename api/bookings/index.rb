# frozen_string_literal: true

require 'services/list_bookings'

module CinemaBooking
  class Bookings < Grape::API
    class Index < Grape::API
      format :json

      get do
        Services::ListBookings.new.(params) do |m|
          m.success do |result|
            result
          end

          m.failure do |error|
            error!({ errors: error }, 422)
          end
        end
      end
    end
  end
end
