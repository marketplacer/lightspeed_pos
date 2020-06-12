# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Orders do
  setup_client_and_account

  it "can fetch orders" do
    VCR.use_cassette("account/orders/index") do
      orders = account.orders.all
      expect(orders).to be_an(Array)
      expect(orders.count).to be > 1

      order = orders.first
      expect(order).to be_a(Lightspeed::Order)
      expect(order.id).to eq(1)
    end
  end

  it "can fetch an order by ID" do
    VCR.use_cassette("account/orders/show") do
      order = account.orders.find(4)
      expect(order).to be_a(Lightspeed::Order)
    end
  end

end
