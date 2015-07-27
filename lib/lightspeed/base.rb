module Lightspeed
  class Base
    attr_accessor :id, :client

    def initialize(client, data={})
      @client = client
      self.id = data.delete(self.class.id_field)
      data.each do |k,v|
        send("#{k}=", v)
      end
    end

    def inspect
      "#<#{self.class.name} id=#{id}>"
    end
  end
end
