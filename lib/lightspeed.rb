require 'httparty'
require 'pry'

module Lightspeed
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
    Lightspeed::Client.basic_auth key, "apikey"
    Lightspeed::Account.basic_auth key, "apikey"
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

end

require 'lightspeed/base'
require 'lightspeed/client'
require 'lightspeed/account'
