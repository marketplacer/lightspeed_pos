# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Inventories do
  setup_client_and_account

  it "gets the inventory for an account" do
    VCR.use_cassette("account/Inventory/index") do
      inventories = account.inventories.all
      expect(inventories.count).to eq(566)
    end
  end

  it "can fetch a single inventory for an account" do
    VCR.use_cassette("account/Inventory/show") do
      inventory = account.inventories.find(2)
      expect(inventory).to be_a(Lightspeed::Inventory)
    end
  end
end
