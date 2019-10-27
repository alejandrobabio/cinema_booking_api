# frozen_string_literal: true

require 'dry/validation'

module CinemaBooking
  module Services
    class CreateBooking
      class Contract < Dry::Validation::Contract
        include Import['repositories.movies']
        include Import['repositories.bookings']

        params do
          required(:booking_date).value(:string)
          required(:movie_id).value(:integer)
          required(:customer_name).value(:string)
        end

        rule(:booking_date) do
          begin
            date = Date.parse(value)
            key.failure('Date in the past') if date < Date.today
          rescue ArgumentError
            key.failure('Invalid date')
          end
        end

        rule(:movie_id, :booking_date) do
          movie = movies.find(values[:movie_id])
          key(:movie_id).failure('Movie not found') unless movie

          if movie
            begin
              weekday = Date.parse(values[:booking_date]).strftime('%a')
              unless movie[:days].include?(weekday)
                key(:booking_date)
                  .failure('Movie not available for this weekday')
              end

              reserved_places = bookings
                .count_for_show(values[:movie_id], values[:booking_date])
              unless reserved_places < 10
                key(:booking_date)
                  .failure('No more places available for this show')
              end
            rescue ArgumentError
              nil
            end
          end
        end
      end
    end
  end
end
