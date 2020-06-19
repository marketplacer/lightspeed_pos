# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::SaleLine do
  setup_client_and_account

  subject do
    Lightspeed::SaleLine.new(context: account, attributes: {
      "saleLineID" => 4,
      "itemID" => 177
    })
  end

  it "can fetch an associated item" do
    VCR.use_cassette("account/items/show") do
      expect(subject.item).to be_a(Lightspeed::Item)
    end
  end

  it "can get the attributes of a sale line" do
    expect(subject.attributes).to eq("saleLineID" => 4, "itemID" => 177)
  end

end


