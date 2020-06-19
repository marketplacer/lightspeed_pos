# frozen_string_literal: true

require_relative 'collection'

require_relative 'item'

module Lightspeed
  class Items < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end
