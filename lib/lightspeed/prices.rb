require 'active_support/core_ext/string'
require 'bigdecimal'

module Lightspeed
  class Prices
    def initialize(attributes)
      @attributes = attributes
    end

    def prices
      @prices ||= @attributes["ItemPrice"].map { |v| [v["useType"].parameterize.underscore.to_sym, BigDecimal.new(v["amount"])] }.to_h
    end

    def to_h
      attributes
    end

    def to_json
      to_h.to_json
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
  end
end
