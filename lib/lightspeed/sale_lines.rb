require_relative 'collection'

require_relative 'sale_line'

module Lightspeed
  class SaleLines < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end


