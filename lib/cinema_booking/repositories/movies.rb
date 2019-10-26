# frozen_string_literal: true

require 'cinema_booking/base_repository'

module CinemaBooking
  module Repositories
    class Movies < BaseRepository
      def create(attrs)
        super(parse_attrs(attrs))
      end

      private

      def parse_attrs(attrs)
        days = attrs[:days]
        if days
          attrs.merge(days: Sequel.pg_array(Array(days)))
        else
          attrs
        end
      end
    end
  end
end
