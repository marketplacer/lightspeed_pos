require 'pp'
module Lightspeed
  class Request
    attr_accessor :raw_request, :bucket_max, :bucket_level

    SECONDS_TO_WAIT_WHEN_THROTTLED = 60 # API requirements.

    class << self
      attr_writer :verbose
    end

    def self.verbose?
      !! @verbose
    end

    def self.base_url
      "https://api.merchantos.com/API"
    end

    def initialize(client, method:, path:, params: nil, body: nil)
      @bucket_max = Float::INFINITY
      @bucket_level = 0
      @raw_request = Typhoeus::Request.new(
        self.class.base_url + path,
        method: method,
        body: body,
        params: params
      )

      if client.oauth_token
        @raw_request.options[:headers].merge!(
          "Authorization" => "OAuth #{client.oauth_token}"
        )
      end

      @raw_request.options[:userpwd] = "#{client.api_key}:apikey" if client.api_key
    end

    def perform
      response = raw_request.run
      extract_rate_limits(response)
      if response.code == 200
        handle_success(response)
      else
        handle_error(response)
      end
    rescue Lightspeed::Error::Throttled
      retry_throttled_request
    end

    private

    def handle_success(response)
      json = JSON.parse(response.body)
      pp json if self.class.verbose?
      json
    end

    def retry_throttled_request
      puts 'retrying throttled request after 60s.' if self.class.verbose?
      sleep SECONDS_TO_WAIT_WHEN_THROTTLED
      perform
    end

    def handle_error(response)
      data = JSON.parse(response.body)
      error = case response.code.to_s
      when '400' then Lightspeed::Error::BadRequest
      when '401' then Lightspeed::Error::Unauthorized
      when '404' then Lightspeed::Error::NotFound
      when '429' then Lightspeed::Error::Throttled
      when /5../ then Lightspeed::Error::InternalServerError
      else Lightspeed::Error
      end
      raise error, data["message"]
    end

    def extract_rate_limits(response)
      if bucket_headers = response.headers["X-LS-API-Bucket-Level"]
        @bucket_level, @bucket_max = bucket_headers.split("/").map(&:to_f)
      end
    end

  end
end
