require_relative 'resource'

module Lightspeed
  class Category < Lightspeed::Resource
    fields(
      categoryID: Lightspeed::ID,
      name: String,
      nodeDepth: Numeric,
      fullPathName: String,
      leftNode: Integer,
      rightNode: Integer,
      createTime: DateTime,
      timeStamp: DateTime,
      parentID: Lightspeed::ID,
      Category: Hash
    )
    relationships Parent: :Category
  end
end
