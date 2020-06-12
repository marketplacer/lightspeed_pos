# frozen_string_literal: true

require_relative 'resource'

module Lightspeed
  class Category < Lightspeed::Resource
    fields(
      categoryID: :id,
      name: :string,
      nodeDepth: :integer,
      fullPathName: :string,
      leftNode: :integer,
      rightNode: :integer,
      createTime: :datetime,
      timeStamp: :datetime,
      parentID: :id,
      Category: :hash
    )
    relationships Parent: :Category
  end
end
