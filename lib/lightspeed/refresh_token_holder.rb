module Lightspeed
  class RefreshTokenHolder

    def initialize(refresh_token:, client_id:, client_secret:)
      @refresh_token = refresh_token
      @client_id = client_id
      @client_secret = client_secret
      @http = Net::HTTP.new(Lightspeed::Request.base_host, 443)
      @http.use_ssl = true
    end

    def token
      if token_expired?
        @update_timestamp = Time.now
        @cached_token = fetch_token
      end
      @cached_token
    end

    private

    def token_expired?
      @cached_token.nil? or @update_timestamp < 10.minutes.ago
    end

    def fetch_token
      response = @http.request(raw_request)
      if response.code == "200"
        handle_success(response)
      else
        handle_error(response)
      end
    end

    def raw_request
      params = {
        "refresh_token" => @refresh_token,
        "client_id" => @client_id,
        "client_secret" => @client_secret,
        "grant_type" => "refresh_token"
      }
      uri = "/oauth/access_token.php"
      request = Net::HTTP::Post.new(uri)
      request.set_form_data params
      request
    end

    def handle_success(response)
      json = Yajl::Parser.parse(response.body)
      json["access_token"]
    end

    def handle_error(response)
      raise Lightspeed::Error, "Error fetching refresh token"
    end
  end
end
