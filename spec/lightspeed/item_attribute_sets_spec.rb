# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::ItemAttributeSets do
  setup_client_and_account

  it "can fetch item attributes for an account" do
    VCR.use_cassette("account/ItemAttributeSet/index") do
      attributes = account.item_attribute_sets.all
      expect(attributes.first.name).to eq("Color/Size")
    end
  end
end
