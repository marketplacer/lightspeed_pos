module Lightspeed
  class Base
    attr_accessor :id, :owner, :attributes

    def initialize(owner, data = {})
      @owner = owner
      @attributes = data
      self.id = data.delete(self.class.id_field)
      data.each do |k, v|
        send("#{k}=", v)
      end
    end

    def inspect
      "#<#{self.class.name} id=#{id}>"
    end

    def to_json
      attributes.to_json
    end
  end
end
