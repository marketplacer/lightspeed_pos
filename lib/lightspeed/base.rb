module Lightspeed
  class Base
    attr_accessor :id

    include HTTParty

    base_uri "https://api.merchantos.com/API/"

    def initialize(data={})
      self.id = data[self.class.id_field]
    end

    def inspect
      "#<#{self.class.name} id=#{id}>"
    end
  end
end
