$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lightspeed'
require 'webmock/rspec'
require 'vcr'

Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each do |f|
  require f
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

