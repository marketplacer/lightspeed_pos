require 'httparty'
require 'pry'

module Lightspeed
  include HTTParty
  base_uri "https://api.merchantos.com/API/"

  # Used to configure Lightspeed.
  #
  # Example:
  #
  # Lightspeed.configure do |c|
  #   c.api_key = "YOUR_API_KEY_GOES_HERE"
  # end
  def self.configure(&block)
    yield self
  end

  private

  # Sets an API key to use for both Lightspeed::Client and Lightspeed::Account
  def self.api_key=(key)
    Lightspeed.basic_auth key, "apikey"
  end

  # Instantiates a bunch of records from Lightspeed into their proper classes.
  def self.instantiate(records, klass)
    records = Lightspeed.splat(records)
    records.map do |record|
      klass.new(record)
    end
  end

  # Converts a thing to an Array unless it is already.
  # Unfortunately necessary because Lightspeed's API may return an object, 
  # or an array of objects.
  def self.splat(thing)
    thing.is_a?(Array) ? thing : [thing]
  end

  def self.request(method, *args)
    response = self.send(method, *args)
    if response.code == 200
      response
    else
      handle_error(response)
    end
  end

  def self.handle_error(response)
    data = JSON.parse(response)
    case response.code
    when 401
      raise Lightspeed::Errors::Unauthorized.new(data["message"])
    end
  end
end

require 'lightspeed/client'
require 'lightspeed/errors'
