require_relative 'collection'

require_relative 'tax_class'

module Lightspeed
  class TaxClasses < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end