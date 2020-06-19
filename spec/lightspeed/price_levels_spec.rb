# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::PriceLevels do
  setup_client_and_account

  describe "#all" do
    it "can fetch price levels" do
      VCR.use_cassette("account/price_levels/index") do
        price_levels = account.price_levels.all
        expect(price_levels).to be_an Array
        expect(price_levels.count).to be > 1

        price_level = price_levels.first
        expect(price_level).to be_a Lightspeed::PriceLevel
        expect(price_level.name).to eq "Default"
      end
    end
  end

  describe "#find" do
    it "can fetch an item by ID" do
      VCR.use_cassette("account/price_levels/show") do
        price_level = account.price_levels.find(1)
        expect(price_level).to be_a Lightspeed::PriceLevel
      end
    end
  end
end
