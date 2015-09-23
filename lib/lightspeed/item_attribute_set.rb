require_relative 'resource'

module Lightspeed
  class ItemAttributeSet < Lightspeed::Resource
    attr_accessor :name, :attributeName1, :attributeName2, :attributeName3
  end
end
