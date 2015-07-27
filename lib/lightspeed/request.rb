module Lightspeed
  class Request
    attr_accessor :request

    def self.base_url
      "https://api.merchantos.com/API"
    end


    def initialize(client, method: , path:, params: nil, body: nil)
      @request = Typhoeus::Request.new(
        self.class.base_url + path, 
        method: method,
        body: body,
        params: params
      )


      if client.oauth_token
        @request.options[:headers].merge!({
          "Authorization" => "OAuth #{client.api_key}"
        })
      end

      if client.api_key
        @request.options[:userpwd] = "#{client.api_key}:apikey"
      end
    end

    def perform
      response = request.run
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
    
      if error
        raise error.new(data["message"])
      end
    end
  end
end
