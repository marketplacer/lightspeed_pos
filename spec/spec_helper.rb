$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lightspeed'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.configure do |c|
  c.before(configure: true) do
    Lightspeed.configure do |c|
      c.api_key = ENV['API_KEY'] || "test"
    end
  end
end

