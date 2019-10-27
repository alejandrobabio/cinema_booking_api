# frozen_string_literal: true

require 'request_helper'

module CinemaBooking
  RSpec.describe Bookings, type: :request do
    def app
      described_class
    end

    let(:movies) { Container['repositories.movies'] }
    let(:bookings) { Container['repositories.bookings'] }
    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'GET /bookings' do
      before do
        7.times do |ix|
          id = movies.create(name: "Die Hard #{ix}", days: [Date::ABBR_DAYNAMES[ix]])
          3.times do |jx|
            bookings.create(
              movie_id: id, customer_name: "John #{ix}#{jx}", booking_date: "2019-11-#{ix + 3}"
            )
          end
        end
      end

      it 'list all bookings between dates' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          get '/bookings?from=2019-11-05&to=2019-11-07', header

          expect(last_response.status).to eq 200
          result = JSON.parse last_response.body
          expect(result.size).to eq 9
          expect(result.first['booking_date']).to eq '2019-11-05'
          expect(result.last['booking_date']).to eq '2019-11-07'
        end
      end

      it 'if any parameter is missing respond with error' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          get '/bookings?from=2019-11-05', header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              to: ['is missing']
            }
          }.to_json
          expect(last_response.body).to eq error

          get '/bookings?to=2019-11-05', header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              from: ['is missing']
            }
          }.to_json
          expect(last_response.body).to eq error
        end
      end

      it 'if to before from respond with error' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          get '/bookings?from=2019-11-09&to=2019-11-07', header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              from: ['from must be before to']
            }
          }.to_json
          expect(last_response.body).to eq error
        end
      end

      it 'with invalid dates respond with error' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          get '/bookings?from=2019-10-39&to=2019-17-07', header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              from: ['Invalid date'],
              to: ['Invalid date']
            }
          }.to_json
          expect(last_response.body).to eq error
        end
      end
    end
  end
end
