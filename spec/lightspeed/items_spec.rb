# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Items do
  setup_client_and_account

  it "can fetch items" do
    VCR.use_cassette("account/items/index") do
      items = account.items.all
      expect(items).to be_an(Array)
      expect(items.count).to be > 1

      item = items.first
      expect(item).to be_a(Lightspeed::Item)
      expect(item.id).to eq(135)
    end
  end

  it "can fetch items where itemMatrixID is 0" do
    VCR.use_cassette("account/items/index_without_item_matrices") do
      items = account.items.all(params: { itemMatrixID: 0 })
      expect(items).to be_an(Array)
      expect(items.count).to be > 1

      item = items.first
      expect(item).to be_a(Lightspeed::Item)
      expect(item.id).to eq(135)
      expect(item.item_matrix).to be_nil
    end
  end

  it "can fetch an item by ID" do
    VCR.use_cassette("account/items/show") do
      item = account.items.find(417)
      expect(item).to be_a(Lightspeed::Item)
    end
  end

  context "creating" do
    it "with valid information" do
      VCR.use_cassette("account/items/create") do
        item = account.items.create(description: "Onesie")
        expect(item).to be_a(Lightspeed::Item)
        expect(item.id).not_to be_nil
      end
    end

    it "missing a description" do
      VCR.use_cassette("account/items/create_invalid") do
        expect do
          account.items.create(description: "")
        end.to raise_error(Lightspeed::Error::BadRequest, "Item not created. An Item must have a description.")
      end
    end
  end

  context "updating" do
    it "with valid information" do
      VCR.use_cassette("account/items/update") do
        id = account.items.create(description: 'Item to update').id
        item = account.items.update(id, description: "T-Shirt Red Small")

        expect(item.description).to eq("T-Shirt Red Small")
      end
    end

    it "missing a description" do
      VCR.use_cassette("account/items/update_invalid") do
        id = account.items.create(description: 'Item to update').id
        expect do
          account.items.update(id, description: "")
        end.to raise_error(Lightspeed::Error::BadRequest, "Item not updated. An Item must have a description.")
      end
    end

    it "an item" do
      VCR.use_cassette("account/items/update") do
        item = account.items.create(description: 'Item to update')
        item.update(description: "T-Shirt Red Small")
        expect(item.description).to eq("T-Shirt Red Small")
      end
    end
  end

  it "can archive an item" do
    VCR.use_cassette("account/items/archive") do
      item = account.items.create(description: 'Item to destroy')
      item.archive
      expect(item.archived).to be true
    end
  end

  it "can archive an item by ID" do
    VCR.use_cassette("account/items/archive") do
      id = account.items.create(description: 'Item to destroy').id
      item = account.items.archive(id)
      expect(item.archived).to be true
    end
  end
end
