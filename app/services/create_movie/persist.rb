# frozen_string_literal: true

require 'dry/transaction/operation'

module CinemaBooking
  module Services
    class CreateMovie
      class Persist
        include Dry::Transaction::Operation
        include Import['repositories.movies']

        def call(params)
          movies.create(params)
          Success('')
        end
      end
    end
  end
end
