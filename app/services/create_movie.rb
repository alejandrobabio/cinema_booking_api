# frozen_string_literal: true

require 'dry/transaction'

module CinemaBooking
  module Services
    class CreateMovie
      include Dry::Transaction(container: Container)

      step :validate, with: 'create_movie.validate'
      step :persist,  with: 'create_movie.persist'
    end
  end
end
