# frozen_string_literal: true

require 'db'

module CinemaBooking
  class BaseRepository
    def initialize(dataset)
      @dataset = dataset
      freeze
    end

    def create(data)
      dataset.insert(data)
    end

    def update(id, data)
      dataset.where(id: id).update(data)
    end

    def delete(id)
      dataset.where(id: id).delete
    end

    def all
      dataset.all
    end

    def find(id)
      dataset.where(id: id).single_record
    end

    private

    attr_reader :dataset
  end
end
