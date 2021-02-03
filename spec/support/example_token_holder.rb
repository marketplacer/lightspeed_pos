# frozen_string_literal: true

class ExampleTokenHolder
  def initialize(token: nil, refresh_token: nil)
    @token = token
    @refresh_token = refresh_token
  end

  def oauth_token
    @token
  end

  def refresh_oauth_token
    @token = "#{@token}_refreshed"
  end
end
