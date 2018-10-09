require_relative 'collection'
require_relative 'transfer'

module Lightspeed
  class Transfers < Lightspeed::Collection
    alias_method :archive, :destroy

    def base_path
      "#{account.base_path}/Inventory/#{resource_name}"
    end
  end
end
