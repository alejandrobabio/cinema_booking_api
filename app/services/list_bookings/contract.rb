# frozen_string_literal: true

require 'dry/validation'

module CinemaBooking
  module Services
    class ListBookings
      class Contract < Dry::Validation::Contract
        params do
          required(:from).value(:string)
          required(:to).value(:string)
        end

        rule(:from, :to) do
          from = to = nil

          begin
            from = Date.parse(values[:from])
          rescue ArgumentError
            key(:from).failure('Invalid date')
          end

          begin
            to = Date.parse(values[:to])
          rescue ArgumentError
            key(:to).failure('Invalid date')
          end

          if from && to && from > to
            key(:from).failure('from must be before to')
          end
        end
      end
    end
  end
end
