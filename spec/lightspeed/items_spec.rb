require 'spec_helper'

describe Lightspeed::Items, configure: true do
  let(:account) do
    Lightspeed::Account.new.tap do |account|
      account.id = 113665
    end
  end

  it "can fetch items" do
    VCR.use_cassette("account/items") do
      items = account.items
      expect(items).to be_an(Array)
      expect(items.count).to eq(2)

      item = items.first
      expect(item).to be_a(Lightspeed::Item)
      expect(item.id).to eq("1")
    end
  end

  it "can fetch an item by ID" do
    VCR.use_cassette("account/item") do
      item = account.find_item(1)
      expect(item).to be_a(Lightspeed::Item)
    end
  end
end
