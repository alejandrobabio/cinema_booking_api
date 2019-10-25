# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
$LOAD_PATH.unshift(File.expand_path('../api', __dir__))
$LOAD_PATH.unshift(File.expand_path('../app', __dir__))

require 'boot'

require 'api'
