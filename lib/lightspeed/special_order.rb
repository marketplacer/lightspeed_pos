# frozen_string_literal: true

require_relative 'resource'

module Lightspeed
  class SpecialOrder < Lightspeed::Resource
    fields(
      specialOrderID: :id,
      qout: :integer,
      contacted: :boolean,
      completed: :boolean,
      customerID: :id,
      shopID: :id,
      saleLineID: :id,
      orderLineID: :id,
      transferItemID: :id,
      OrderLine: :hash
    )

    relationships :SaleLine, :Shop
  end
end


