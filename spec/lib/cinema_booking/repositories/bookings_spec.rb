# frozen_string_literal: true

require 'db_helper'
require 'cinema_booking/repositories/bookings'

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
  end
end
