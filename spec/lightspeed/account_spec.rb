require 'spec_helper'

describe Lightspeed::Account do
  Lightspeed.configure do |c|
    c.api_key = "test"
  end

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
      expect(item).to be_an(Lightspeed::Item)
      expect(item.id).to eq("1")
    end
  end
end
