require_relative 'resource'

module Lightspeed
  class Category < Lightspeed::Resource
    attr_accessor :name, :nodeDepth, :fullPathName, :leftNode, :rightNode, :timeStamp, :parentID,
      :createTime
  end
end
