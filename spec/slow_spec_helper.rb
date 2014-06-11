# Why is this a slow_spec_helper instead of spec_helper
# Because it is extremely slow to load all of the following dependencies:
#
# * SimpleCov
# * EngineCart (and therefore the underlying internal Rails application)
ENV['RAILS_ENV'] ||= 'test'
if ENV['COV'] || ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
  SimpleCov.command_name 'spec'
end

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!('rails')
end

require 'engine_cart'
require File.expand_path('../internal/config/environment.rb',  __FILE__)

EngineCart.load_application!

require 'rspec-html-matchers'

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require 'spec_helper'` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.raise_errors_for_deprecations!
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
