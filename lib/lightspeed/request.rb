module Lightspeed
  class Request
    attr_accessor :raw_request

    def self.base_url
      "https://api.merchantos.com/API"
    end

    def initialize(client, method:, path:, params: nil, body: nil)
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

      if client.api_key
        @raw_request.options[:userpwd] = "#{client.api_key}:apikey"
      end
    end

    def perform
      response = raw_request.run
      if response.code == 200
        handle_success(response)
      else
        handle_error(response)
      end
    end

    private

    def handle_success(response)
      JSON.parse(response.body)
    end

    def handle_error(response)
      data = JSON.parse(response.body)
      error = case response.code
      when 400
        Lightspeed::Errors::BadRequest
      when 401
        Lightspeed::Errors::Unauthorized
      end

      raise error.new(data["message"]) if error
    end
  end
end
