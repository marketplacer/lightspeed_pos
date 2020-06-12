# frozen_string_literal: true

require_relative 'collection'

require_relative 'order'

module Lightspeed
  class Orders < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end

