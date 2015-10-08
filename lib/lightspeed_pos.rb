require 'typhoeus'
require 'json'
require 'pry' if Rails.env.development?

module Lightspeed
end

require_relative 'lightspeed/client'
require_relative 'lightspeed/error'
