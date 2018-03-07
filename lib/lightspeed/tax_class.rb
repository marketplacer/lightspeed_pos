require_relative 'resource'

module Lightspeed
  class TaxClass < Lightspeed::Resource
    fields(
      taxClassID: :id,
      name: :string,
      SaleLine: :hash,
      Items: :hash,
      timeStamp: :datetime
    )
  end
end
