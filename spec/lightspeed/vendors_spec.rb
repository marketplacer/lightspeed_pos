# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Vendors do
  setup_client_and_account

  it "can fetch vendors" do
    VCR.use_cassette("account/vendors/index") do
      vendors = account.vendors.all
      expect(vendors).to be_an(Array)
      expect(vendors.count).to be > 1

      vendor = vendors.first
      expect(vendor).to be_a(Lightspeed::Vendor)
      expect(vendor.id).to eq(1)
    end
  end

  it "can fetch a vendor by ID" do
    VCR.use_cassette("account/vendors/show") do
      vendor = account.vendors.find(1)
      expect(vendor).to be_a(Lightspeed::Vendor)
    end
  end

  context "creating" do
    it "with valid information" do
      VCR.use_cassette("account/vendors/create") do
        vendor = account.vendors.create(accountNumber: "testAccountNumber123", name: 'Test Vendor 1A')
        expect(vendor).to be_a(Lightspeed::Vendor)
        expect(vendor.id).not_to be_nil
      end
    end
  end

  context "updating" do
    it "with valid information" do
      VCR.use_cassette("account/vendors/update") do
        id = account.vendors.create(accountNumber: 'testAccountNumber456', name: 'Test Vendor 2B').id
        vendor = account.vendors.update(id, accountNumber: "testAccountNumber789")
        expect(vendor.accountNumber).to eq("testAccountNumber789")
      end
    end

    it "a vendor" do
      VCR.use_cassette("account/vendors/update") do
        vendor = account.vendors.create(accountNumber: 'testAccountNumber000', name: 'Test Vendor 3C')
        vendor.update(accountNumber: "testAccountNumber111")
        expect(vendor.accountNumber).to eq("testAccountNumber111")
      end
    end
  end

  it "can archive a vendor" do
    VCR.use_cassette("account/vendors/archive") do
      vendor = account.vendors.create(accountNumber: 'bornToDie', name: 'Test Vendor 4D')
      vendor.archive
      expect(vendor.archived).to be true
    end
  end

  it "can archive a vendor by ID" do
    VCR.use_cassette("account/vendors/archive") do
      id = account.vendors.create(accountNumber: 'destroyMe', name: 'Test Vendor 5E').id
      vendor = account.vendors.archive(id)
      expect(vendor.archived).to be true
    end
  end
end
