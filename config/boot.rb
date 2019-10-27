# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

Bundler.require :default, ENV['RACK_ENV']

require 'cinema_booking/container'

CinemaBooking::Container.finalize!
require 'cinema_booking/import'
