# frozen_string_literal: true

require 'services/create_movie'

module CinemaBooking
  class Movies < Grape::API
    class Create < Grape::API
      format :json

      post do
        Services::CreateMovie.new.(params) do |m|
          m.success do
            status 201
          end

          m.failure do |error|
            error!({ errors: error }, 422)
          end
        end
      end
    end
  end
end
