# frozen_string_literal: true

require 'movies/create'
require 'movies/index'

module CinemaBooking
  class Movies < Grape::API
    namespace :movies do
      mount Create
      mount Index
    end
  end
end
