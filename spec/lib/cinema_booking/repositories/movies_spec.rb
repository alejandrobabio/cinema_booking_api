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
  end
end
