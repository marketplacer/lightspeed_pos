# frozen_string_literal: true

require 'active_support/core_ext/string'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
Dotenv.load
require 'lightspeed_pos'
require 'webmock/rspec'
require 'vcr'
Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].sort.each do |f|
  require f
end

Lightspeed::TEST_OAUTH_TOKEN = ENV['LIGHTSPEED_OAUTH_TOKEN']
Lightspeed::TEST_OAUTH_REFRESH_TOKEN = ENV['LIGHTSPEED_OAUTH_REFRESH_TOKEN']
Lightspeed::TEST_ACCOUNT_ID = ENV['LIGHTSPEED_ACCOUNT_ID'].to_i

VCR.configure do |config|
  config.register_request_matcher :anonymised_path do |*reqs|
    reqs.map { |req| URI(req.uri).path.sub(%r{(/API/Account/\d*)}, '/API/Account/-') }.uniq.size == 1
  end

  config.before_record do |recording|
    recording.ignore! if [422].include? recording.response.status.code
  end

  unless Lightspeed::TEST_OAUTH_TOKEN.blank?
    config.filter_sensitive_data('OAuth Token') { Lightspeed::TEST_OAUTH_TOKEN }
  end
  unless Lightspeed::TEST_OAUTH_REFRESH_TOKEN.blank?
    config.filter_sensitive_data('OAuth Refresh Token') { Lightspeed::TEST_OAUTH_REFRESH_TOKEN }
  end
  unless Lightspeed::TEST_ACCOUNT_ID.blank?
    config.filter_sensitive_data('/API/Account/-') { "/API/Account/#{Lightspeed::TEST_ACCOUNT_ID}" }
  end

  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:anonymised_path, :method, :body]
  }
end
