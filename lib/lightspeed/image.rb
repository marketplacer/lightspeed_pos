require_relative 'resource'

require_relative 'item'
require_relative 'item_matrix'

module Lightspeed
  class Image < Lightspeed::Resource
    fields(
      imageId: Lightspeed::ID,
      description: String,
      filename: String,
      publicID: String, # part of the file path; not a Lightspeed ID
      itemID: Lightspeed::ID,
      itemMatrixID: Lightspeed::ID,
      Item: Hash,
      ItemMatrix: Hash
    )

    relationships :Item, :ItemMatrix

    def url
      "#{baseImageURL}#{publicID}"
    end

    def base_path
      if context.is_a?(Lightspeed::Item) ||
         context.is_a?(Lightspeed::ItemMatrix)
        "#{context.base_path}/#{resource_name}/#{id}"
      else
        super
      end
    end
  end
end
