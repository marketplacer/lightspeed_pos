# frozen_string_literal: true

require 'active_support/core_ext/string'

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'dotenv'
Dotenv.load
require 'lightspeed_pos'
require 'webmock/rspec'
require 'vcr'
Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each do |f|
  require f
end

Lightspeed::TEST_OAUTH_TOKEN = ENV.fetch('LIGHTSPEED_OAUTH_TOKEN', nil)
Lightspeed::TEST_OAUTH_REFRESH_TOKEN = ENV.fetch('LIGHTSPEED_OAUTH_REFRESH_TOKEN', nil)
Lightspeed::TEST_ACCOUNT_ID = ENV.fetch('LIGHTSPEED_ACCOUNT_ID', nil).to_i

VCR.configure do |config|
  config.register_request_matcher :anonymised_path do |*reqs|
    reqs.map { |req| URI(req.uri).path.sub(%r{(/API/Account/\d*)}, '/API/Account/-') }.uniq.size == 1
  end

  config.before_record do |recording|
    recording.ignore! if [422].include? recording.response.status.code
  end

  config.filter_sensitive_data('OAuth Token') { Lightspeed::TEST_OAUTH_TOKEN } unless Lightspeed::TEST_OAUTH_TOKEN.blank?
  config.filter_sensitive_data('OAuth Refresh Token') { Lightspeed::TEST_OAUTH_REFRESH_TOKEN } unless Lightspeed::TEST_OAUTH_REFRESH_TOKEN.blank?
  config.filter_sensitive_data('/API/Account/-') { "/API/Account/#{Lightspeed::TEST_ACCOUNT_ID}" } unless Lightspeed::TEST_ACCOUNT_ID.blank?

  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:anonymised_path, :method, :body]
  }
end
