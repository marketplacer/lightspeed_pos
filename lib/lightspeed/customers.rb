require_relative 'collection'

require_relative 'customer'

module Lightspeed
  class Customers < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end