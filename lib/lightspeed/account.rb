module Lightspeed
  class Account < Lightspeed::Base
    attr_accessor :id

    private

    def self.id_field
      "accountID"
    end
  end
end
