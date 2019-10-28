# frozen_string_literal: true

require 'request_helper'

module CinemaBooking
  RSpec.describe Movies, type: :request do
    def app
      described_class
    end

    let(:repo) { Container['repositories.movies'] }
    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'POST /movies' do
      it 'returns created' do
        input = { name: 'Die Hard', days: %w[Mon Fri] }
        post '/movies', input, header

        expect(last_response.status).to eq 201
      end

      it 'creates a new movie with provided data' do
        input = {
          name: 'Die Hard',
          description: 'Nakatomi Plaza kidnapping',
          image_url: 'https://upload.wikimedia.org/wikipedia/en/7/7e/Die_hard.jpg',
          days: %w[Mon Sat]
        }

        expect {
          post '/movies', input, header
        }.to change(repo, :count).by(1)

        movie_data = repo.all.first.slice(*input.keys)
        expect(movie_data).to eq input
      end

      it 'can\'t create with an empty name' do
        input = { name: nil, days: ['Mon'] }
        post '/movies', input, header

        expect(last_response.status).to eq 422

        error = {
          errors: {
            name: ['must be a string']
          }
        }
        expect(last_response.body).to eq error.to_json
      end

      it 'can\'t create with empty days' do
        input = { name: 'Die Hard', days: [] }
        post '/movies', input, header

        expect(last_response.status).to eq 422

        error = {
          errors: {
            days: {
              0 => ['must be one of: Sun, Mon, Tue, Wed, Thu, Fri, Sat']
            }
          }
        }
        expect(last_response.body).to eq error.to_json
      end

      it 'can\'t create without name or days' do
        input = {}
        post '/movies', input, header

        expect(last_response.status).to eq 422

        error = {
          errors: {
            name: ['is missing'], days: ['is missing']
          }
        }
        expect(last_response.body).to eq error.to_json
      end

      it 'can\' create duplicated' do
        input = { name: 'Die Hard', days: %w[Mon Fri] }
        repo.create(input)

        post '/movies', input, header

        expect(last_response.status).to eq 422

        error = {
          errors: {
            name: ['Die Hard: already exists']
          }
        }
        expect(last_response.body).to eq error.to_json
      end
    end
  end
end
