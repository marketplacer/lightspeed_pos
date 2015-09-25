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
      timeStamp: DateTime,
      parentID: Lightspeed::ID,
      createTime: DateTime
    )
    relationships Parent: :Category
  end
end
