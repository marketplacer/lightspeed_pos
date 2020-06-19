# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Item do
  setup_client_and_account

  subject do
    Lightspeed::Item.new(context: account, attributes: { "itemID" => 2 })
  end

  it "can fetch an item's ItemMatrix" do
    subject.itemMatrixID = 1
    VCR.use_cassette("account/ItemMatrix/show") do
      matrix = subject.item_matrix
      expect(matrix).to be_a(Lightspeed::ItemMatrix)
    end
  end

  it "does not fetch an item matrix if itemMatrixID is nil" do
    # Yes, Lightspeed's API returns 0 for an ID, rather than `null`.
    subject.itemMatrixID = "0"
    expect(subject.item_matrix).to be_nil
  end

  it "can fetch an item's default Vendor" do
    subject.defaultVendorID = "1"
    VCR.use_cassette("account/vendors/show") do
      vendor = subject.default_vendor
      expect(vendor).to be_a(Lightspeed::Vendor)
    end
  end

  it "does not fetch an item's default vendor if defaultVendorID is nil" do
    subject.defaultVendorID = "0"
    expect(subject.default_vendor).to be_nil
  end

  it "can get the attributes of an item" do
    expect(subject.attributes).to eq("itemID" => 2)
  end

  it "can show a JSON representation of an item" do
    expect(subject.to_json).to eq("{\"itemID\":2}")
  end
end
