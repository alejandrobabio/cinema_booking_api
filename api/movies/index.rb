# frozen_string_literal: true

require 'services/list_movies'
require 'entities/movie'

module CinemaBooking
  class Movies < Grape::API
    class Index < Grape::API
      format :json

      get do
        Services::ListMovies.new.(params) do |m|
          m.success do |result|
            present result, with: Entities::Movie
          end

          m.failure do |error|
            error!({ errors: error }, 422)
          end
        end
      end
    end
  end
end
