# frozen_string_literal: true

require 'dry/transaction/operation'
require 'dry/schema'

module CinemaBooking
  module Services
    class ListMovies
      class Validate
        include Dry::Transaction::Operation

        Schema = Dry::Schema.JSON do
          required(:day).filled(:string, included_in?: Date::ABBR_DAYNAMES)
        end
        private_constant :Schema

        def call(params)
          result = Schema.(params)
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
