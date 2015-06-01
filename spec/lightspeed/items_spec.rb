require 'spec_helper'

describe Lightspeed::Items, configure: true do
  let(:account) do
    Lightspeed::Account.new.tap do |account|
      account.id = 113665
    end
  end

  it "can fetch items" do
    VCR.use_cassette("account/items") do
      items = account.items.all
      expect(items).to be_an(Array)
      expect(items.count).to eq(2)

      item = items.first
      expect(item).to be_a(Lightspeed::Item)
      expect(item.id).to eq("1")
    end
  end

  it "can fetch an item by ID" do
    VCR.use_cassette("account/item") do
      item = account.items.find(1)
      expect(item).to be_a(Lightspeed::Item)
    end
  end

  context "creating" do
    it "with valid information" do
      VCR.use_cassette("account/create_item") do
        item = account.items.create({
          description: "Onesie"
        })
        expect(item).to be_a(Lightspeed::Item)
        expect(item.id).not_to be_nil
      end
    end

    it "missing a description" do
      VCR.use_cassette("account/create_invalid_item") do
        expect do
          item = account.items.create({
            description: ""
          })
        end.to raise_error(Lightspeed::Errors::BadRequest, "Item not created. An Item must have a description.")
      
      end
    end
  end

  context "updating" do
    it "with valid information" do
      VCR.use_cassette("account/update_item") do
        item = account.items.update(1, {
          description: "Onesie"
        })
        expect(item.description).to eq("Onesie")
      end
    end

    it "missing a description" do
      VCR.use_cassette("account/invalid_update_item") do
        expect do
          item = account.items.update(1, {
            description: ""
          })
        end.to raise_error(Lightspeed::Errors::BadRequest, "Item not updated. An Item must have a description.")
      end
    end
  end
end
