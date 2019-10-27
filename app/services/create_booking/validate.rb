# frozen_string_literal: true

require 'dry/transaction/operation'
require 'services/create_booking/contract'

module CinemaBooking
  module Services
    class CreateBooking
      class Validate
        include Dry::Transaction::Operation

        def call(params)
          result = Contract.new.(params)
          if result.success?
            Success(result.to_h)
          else
            Failure(result.errors.to_h)
          end
        end
      end
    end
  end
end
