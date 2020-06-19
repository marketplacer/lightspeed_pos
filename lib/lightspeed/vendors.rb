# frozen_string_literal: true

require_relative 'collection'

require_relative 'vendor'

module Lightspeed
  class Vendors < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end
