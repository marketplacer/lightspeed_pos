require_relative 'resource'

module Lightspeed
  class Shop < Lightspeed::Resource
    alias_method :archive, :destroy
    
    attr_accessor :name

    relate :Items
  end
end




