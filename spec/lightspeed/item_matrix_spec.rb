# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::ItemMatrix do
  setup_client_and_account

  subject do
    Lightspeed::ItemMatrix.new(context: account, attributes: { itemMatrixID: 2 })
  end

  it "can fetch an item matrix's attribute set" do
    subject.itemAttributeSetID = 2
    VCR.use_cassette("account/ItemAttributeSet/show") do
      attribute_set = subject.item_attribute_set
      expect(attribute_set).to be_a(Lightspeed::ItemAttributeSet)
    end
  end
end
