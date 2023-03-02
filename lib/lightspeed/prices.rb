# frozen_string_literal: true

require 'active_support/core_ext/string'
require 'bigdecimal'

module Lightspeed
  class Prices
    def initialize(attributes)
      @attributes = attributes
    end

    def prices
      @prices ||= @attributes["ItemPrice"].to_h { |v| [v["useType"].parameterize.underscore.to_sym, BigDecimal(v["amount"])] }
    end

    def as_json
      attributes
    end
    alias to_h as_json

    def to_json
      Yajl::Encoder.encode(as_json)
    end

    def [](key)
      prices[key]
    end

    def inspect
      prices.inspect
    end

    def respond_to?(method, private_method)
      prices.keys.include?(method) || super
    end

    def method_missing(method, *args, &block)
      if prices.keys.include?(method)
        prices[method]
      else
        super
      end
    end

    def respond_to_missing?(method, *)
      prices.keys.include?(method) || super
    end
  end
end
