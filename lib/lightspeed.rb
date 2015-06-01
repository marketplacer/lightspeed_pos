module Lightspeed
  def self.configure(&block)
    yield self
  end

  def self.api_key=(key)
    Lightspeed::Client.basic_auth key, "apikey"
    Lightspeed::Account.basic_auth key, "apikey"
  end
end
