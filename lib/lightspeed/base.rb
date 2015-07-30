module Lightspeed
  class Base
    attr_accessor :id, :owner

    def initialize(owner, data = {})
      @owner = owner
      self.id = data.delete(self.class.id_field)
      data.each do |k, v|
        send("#{k}=", v)
      end
    end

    def inspect
      "#<#{self.class.name} id=#{id}>"
    end
  end
end
