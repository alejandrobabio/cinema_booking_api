# frozen_string_literal: true

require 'request_helper'

module CinemaBooking
  RSpec.describe Movies, type: :request do
    def app
      described_class
    end

    let(:repo) { Container['repositories.movies'] }
    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'GET /movies' do
      before do
        7.times do |ix|
          repo.create(name: "Die Hard #{ix}", days: Date::ABBR_DAYNAMES[ix..-1])
        end
      end

      it 'list all movies for the Monday' do
        get '/movies?day=Mon', header

        expect(last_response.status).to eq 200

        names = JSON.parse(last_response.body).map { |m| m['name'] }
        expect(names).to eq ['Die Hard 0', 'Die Hard 1']
      end

      it 'list all movies for the Friday' do
        get '/movies?day=Fri', header

        expect(last_response.status).to eq 200

        names = JSON.parse(last_response.body).map { |m| m['name'] }
        expect(names).to eq [
          'Die Hard 0', 'Die Hard 1',
          'Die Hard 2', 'Die Hard 3',
          'Die Hard 4', 'Die Hard 5'
        ]
      end
    end
  end
end
