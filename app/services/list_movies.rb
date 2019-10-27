# frozen_string_literal: true

require 'dry/transaction'

module CinemaBooking
  module Services
    class ListMovies
      include Dry::Transaction(container: Container)

      step :validate, with: 'list_movies.validate'
      step :list,     with: 'list_movies.list'
    end
  end
end
