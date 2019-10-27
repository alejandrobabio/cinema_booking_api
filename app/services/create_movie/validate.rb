# frozen_string_literal: true

require 'dry/transaction/operation'
require 'dry/schema'

module CinemaBooking
  module Services
    class CreateMovie
      class Validate
        include Dry::Transaction::Operation

        Schema = Dry::Schema.JSON do
          required(:name).filled(:string)
          optional(:description).maybe(:string)
          optional(:image_url)
            .maybe(format?: %r{^http(s?):\/\/.*\.(jpeg|jpg|gif|png)$})
          optional(:days).maybe do
            array do
              value(:str?, included_in?: Date::ABBR_DAYNAMES)
            end
          end
        end
        private_constant :Schema

        def call(params)
          result = Schema.(params)
          if result.success?
            Success(result.to_h)
          else
            Failure(result.errors.to_h)
          end
        end
      end
    end
  end
end
