require 'uri'
require_relative 'categories'
require_relative 'items'
require_relative 'item_matrices'
require_relative 'item_attribute_sets'
require_relative 'images'
require_relative 'inventories'

module Lightspeed
  class Account < Lightspeed::Resource

    fields(
      accountID: Lightspeed::ID,
      name: String,
      link: URI
    )
    relationships(
      :Items,
      :Categories,
      :ItemMatrices,
      :ItemAttributeSets,
      :Images,
      :Inventories
    )

    def account
      self
    end


  end
end
