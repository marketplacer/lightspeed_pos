# frozen_string_literal: true

require_relative 'resource'

require_relative 'item'
require_relative 'item_matrix'

module Lightspeed
  class Image < Lightspeed::Resource
    fields(
      imageID: :id,
      description: :string,
      filename: :string,
      baseImageURL: :string,
      publicID: :string, # part of the file path; not a Lightspeed ID
      itemID: :id,
      itemMatrixID: :id,
      Item: :hash,
      ItemMatrix: :hash
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
