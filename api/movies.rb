# frozen_string_literal: true

require 'movies/create'

module CinemaBooking
  class Movies < Grape::API
    namespace :movies do
      mount Create
    end
  end
end
