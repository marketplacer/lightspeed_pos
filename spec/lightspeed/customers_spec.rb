require 'spec_helper'

describe Lightspeed::Customers do
  setup_client_and_account

  it "can fetch customers" do
    VCR.use_cassette("account/customers/index") do
      customers = account.customers.all
      expect(customers).to be_an(Array)
      expect(customers.count).to be >= 1

      customer = customers.first

      expect(customer).to be_a(Lightspeed::Customer)
    end
  end

  it "can fetch a customer by ID" do
    VCR.use_cassette("account/customers/show") do
      customer = account.customers.find(1)
      expect(customer).to be_a(Lightspeed::Customer)
    end
  end
end
