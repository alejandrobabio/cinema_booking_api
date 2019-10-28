# frozen_string_literal: true

module CinemaBooking
  module Entities
    class Movie < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :days
      expose :image_url
    end
  end
end
