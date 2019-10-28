# frozen_string_literal: true

require 'request_helper'

module CinemaBooking
  RSpec.describe Bookings, type: :request do
    def app
      described_class
    end

    let(:movies_repo) { Container['repositories.movies'] }
    let(:repo) { Container['repositories.bookings'] }

    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'POST /bookings' do
      let(:movie_id) { movies_repo.create(name: 'Die Hard', days: %w[Mon Tue]) }

      it 'with valid data returns created' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          input = { movie_id: movie_id, customer_name: 'John Doe', booking_date: '2019-11-05' }
          expect {
            post '/bookings', input, header
          }.to change(repo, :count).from(0).to(1)

          expect(last_response.status).to eq 201
        end
      end

      it 'with invalid movie_id returns error' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          input = { movie_id: (movie_id + 1), customer_name: 'John Doe', booking_date: '2019-11-05' }
          post '/bookings', input, header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              movie_id: ['Movie not found']
            }
          }
          expect(last_response.body).to eq error.to_json
        end
      end

      it 'with invalid date returns error' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          input = { movie_id: movie_id, customer_name: 'John Doe', booking_date: '2019-11-32' }
          post '/bookings', input, header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              booking_date: ['Invalid date']
            }
          }
          expect(last_response.body).to eq error.to_json
        end
      end

      it 'with past date returns error' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          input = { movie_id: movie_id, customer_name: 'John Doe', booking_date: '2019-10-08' }
          post '/bookings', input, header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              booking_date: ['Date in the past']
            }
          }
          expect(last_response.body).to eq error.to_json
        end
      end

      it 'with wrong weekday returns error' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          input = { movie_id: movie_id, customer_name: 'John Doe', booking_date: '2019-11-06' }
          post '/bookings', input, header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              booking_date: ['Movie not available for this weekday']
            }
          }
          expect(last_response.body).to eq error.to_json
        end
      end

      it 'allow upto 10 places each day' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          9.times do |i|
            input = { movie_id: movie_id, customer_name: "John #{i}", booking_date: '2019-11-05' }
            repo.create input
          end
          input = { movie_id: movie_id, customer_name: 'John Doe 10', booking_date: '2019-11-05' }
          expect {
            post '/bookings', input, header
          }.to change(repo, :count).from(9).to(10)

          input = { movie_id: movie_id, customer_name: 'John Doe 11', booking_date: '2019-11-05' }
          post '/bookings', input, header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              booking_date: ['No more places available for this show']
            }
          }
          expect(last_response.body).to eq error.to_json
        end
      end

      it 'do not allow duplicates' do
        Timecop.freeze(Date.new(2019, 10, 28)) do
          input = { movie_id: movie_id, customer_name: 'John Doe', booking_date: '2019-11-05' }
          repo.create(input)

          post '/bookings', input, header

          expect(last_response.status).to eq 422

          error = {
            errors: {
              base: [
                "Booking Date: 2019-11-05, Movie id: #{movie_id}, "\
                'Customer Name: John Doe: combination already exists'
              ]
            }
          }
          expect(last_response.body).to eq error.to_json
        end
      end
    end
  end
end
