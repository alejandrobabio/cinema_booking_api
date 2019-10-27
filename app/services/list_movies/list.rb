# frozen_string_literal: true

require 'dry/transaction/operation'

module CinemaBooking
  module Services
    class ListMovies
      class List
        include Dry::Transaction::Operation
        include Import['repositories.movies']

        def call(params)
          Success(
            movies.for_day(params[:day])
          )
        end
      end
    end
  end
end
