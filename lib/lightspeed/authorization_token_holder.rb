module Lightspeed
  class AuthorizationTokenHolder
    def initialize(oauth_token: nil)
      @oauth_token = oauth_token
    end
    def token
      @oauth_token
    end
  end
end
