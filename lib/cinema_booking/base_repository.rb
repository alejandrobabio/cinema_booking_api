# frozen_string_literal: true

require 'cinema_booking/db'

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

    def count
      dataset.count
    end

    def preload(results, key, table)
      ids = results.map { |result| result[key] }.uniq
      records = DB[table].where(id: ids).all
      results.map do |result|
        singular = key.to_s.gsub(/_id$/, '').to_sym
        result[singular] = records.detect { |rec| rec[:id] == result[key] }

        result
      end
    end

    private

    attr_reader :dataset
  end
end
