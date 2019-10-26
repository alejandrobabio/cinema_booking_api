# frozen_string_literal: true

require 'db_helper'
# require 'cinema_booking/repositories/bookings'

module CinemaBooking
  RSpec.describe Repositories::Bookings do
    let(:movies_repo) { Container['repositories.movies'] }
    let(:repo) { Container['repositories.bookings'] }

    it { expect(true).to be_truthy }

    describe '#create' do
      let(:movie_id) { movies_repo.create(name: 'Die Hard') }

      it 'creates a booking record' do
        expect {
          repo.create(
            movie_id: movie_id,
            booking_date: '2019-11-05',
            customer_name: 'Bruce Willis'
          )
        }.to change(repo, :count).from(0).to(1)
      end
    end

    describe '#list_between_dates' do
      it 'list only bookings between given dates' do
        movie_id1 = movies_repo.create(name: 'Die Hard')
        movie_id2 = movies_repo.create(name: 'Die Hard 2')

        (1..5).each do |day|
          repo.create(
            movie_id: movie_id1,
            booking_date: "2019-11-#{day}",
            customer_name: %w[John Maire].sample
          )
          repo.create(
            movie_id: movie_id2,
            booking_date: "2019-11-#{day}",
            customer_name: %w[Frank Ana].sample
          )
        end

        expect(repo.count).to eq 10
        result = repo.list_between_dates('2019-11-02', '2019-11-04')
        expect(result.size).to eq 6
        expect(result.first[:movie][:name]).to match(/Die Hard/)
      end
    end
  end
end
