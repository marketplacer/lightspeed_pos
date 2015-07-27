require 'spec_helper'

describe Lightspeed::Items, configure: true do
  let(:account) do
    Lightspeed::Account.new(client).tap do |account|
      account.id = 113665
    end
  end

  it "can fetch items" do
    VCR.use_cassette("account/items/index") do
      items = account.items.all
      expect(items).to be_an(Array)
      expect(items.count).to eq(2)

      item = items.first
      expect(item).to be_a(Lightspeed::Item)
      expect(item.id).to eq("1")
    end
  end

  it "can fetch an item by ID" do
    VCR.use_cassette("account/items/show") do
      item = account.items.find(1)
      expect(item).to be_a(Lightspeed::Item)
    end
  end

  context "creating" do
    it "with valid information" do
      VCR.use_cassette("account/items/create") do
        item = account.items.create({
          description: "Onesie"
        })
        expect(item).to be_a(Lightspeed::Item)
        expect(item.id).not_to be_nil
      end
    end

    it "missing a description" do
      VCR.use_cassette("account/items/create_invalid") do
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
      VCR.use_cassette("account/items/update") do
        item = account.items.update(1, {
          description: "Onesie"
        })
        expect(item.description).to eq("Onesie")
      end
    end

    it "missing a description" do
      VCR.use_cassette("account/items/update_invalid") do
        expect do
          item = account.items.update(1, {
            description: ""
          })
        end.to raise_error(Lightspeed::Errors::BadRequest, "Item not updated. An Item must have a description.")
      end
    end
  end

  it "can archive an item" do
    VCR.use_cassette("account/items/archive") do
      item = account.items.archive(1)
      expect(item.archived).to eq("true")
    end
  end
end
