# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler/setup'

Bundler.require ENV['RACK_ENV']
