require 'active_support/core_ext/string'

module Lightspeed
  class Base
    attr_accessor :owner

    def initialize(owner)
      @owner = owner
    end

    def account
      owner.account
    end

    def client
      owner.client
    end

    def inspect
      "#<#{self.class.name}>"
    end

    def instantiate(**args)
      account.instantiate({kind: self.class, owner: self}.merge(args))
    end
  end
end
