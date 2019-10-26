# frozen_string_literal: true

require 'db_helper'
require 'cinema_booking/repositories/movies'

module CinemaBooking
  RSpec.describe Repositories::Movies do
    let(:repo) { Container['repositories.movies'] }

    it { expect(true).to be_truthy }

    describe '#create' do
      it 'creates a movie record' do
        expect {
          repo.create(
            name: 'Die Hard',
            description: 'Nakatomi Plaza kidnapping',
            image_url: 'https://upload.wikimedia.org/wikipedia/en/7/7e/Die_hard.jpg'
          )
        }.to change(repo, :count).from(0).to(1)
      end

      it 'create with days allowed' do
        id = repo.create(name: 'Die Hard 2', days: %w[Mon Sat])
        expect(repo.find(id)[:days]).to eq %w[Mon Sat]
      end

      it 'create with days allowed' do
        id = repo.create(name: 'Die Hard 3', days: 'Tue')
        expect(repo.find(id)[:days]).to eq %w[Tue]
      end
    end

    describe '#for_day' do
      before do
        repo.create(name: 'Die Hard', days: %w[Mon Sat])
        repo.create(name: 'Die Hard 2', days: %w[Wen Sat])
        repo.create(name: 'Die Hard 3', days: %w[Mon Sat])
      end

      it 'find all movies for Sat' do
        movies_names = ['Die Hard', 'Die Hard 2', 'Die Hard 3']
        result = repo.for_day('Sat').map { |movie| movie[:name] }
        expect(result).to eq movies_names
      end

      it 'find all movies for Mon' do
        movies_names = ['Die Hard', 'Die Hard 3']
        result = repo.for_day('Mon').map { |movie| movie[:name] }
        expect(result).to eq movies_names
      end

      it 'find all movies for Wen' do
        movies_names = ['Die Hard 2']
        result = repo.for_day('Wen').map { |movie| movie[:name] }
        expect(result).to eq movies_names
      end

      it 'return empty result for Fri' do
        expect(repo.for_day('Fri')).to eq []
      end
    end
  end
end
