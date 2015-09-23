$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
require 'lightspeed_pos'
require 'webmock/rspec'
require 'vcr'
Dotenv.load
Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each do |f|
  require f
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { record: :new_episodes }
end
