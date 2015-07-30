module Lightspeed
  class Category < Base
    attr_accessor :name, :nodeDepth, :fullPathName, :leftNode, :rightNode, :timeStamp, :parentID,
      :createTime

    def self.id_field
      "categoryID"
    end
  end
end
