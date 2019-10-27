# frozen_string_literal: true

require 'dry/auto_inject'

module CinemaBooking
  Import = Dry::AutoInject(Container)
end
