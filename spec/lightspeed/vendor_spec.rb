# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Vendor do
  setup_client_and_account

  subject do
    Lightspeed::Vendor.new(context: account, attributes: { "vendorID" => 6 })
  end

  it "can get the attributes of an vendor" do
    expect(subject.attributes).to eq("vendorID" => 6)
  end

  it "can show a JSON representation of an vendor" do
    expect(subject.to_json).to eq("{\"vendorID\":6}")
  end

end
