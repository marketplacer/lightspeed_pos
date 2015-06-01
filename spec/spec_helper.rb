$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lightspeed'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.configure do |c|
  c.before(configured: true) do
    Lightspeed.configure do |c|
      c.api_key = "test"
    end
  end
end

