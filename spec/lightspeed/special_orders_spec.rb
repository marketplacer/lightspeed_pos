# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::SpecialOrders do
  setup_client_and_account

  it "can fetch special orders" do
    VCR.use_cassette("account/special_orders/index") do
      special_orders = account.special_orders.all
      expect(special_orders).to be_an(Array)
      expect(special_orders.count).to be > 1

      special_order = special_orders.first
      expect(special_order).to be_a(Lightspeed::SpecialOrder)
      expect(special_order.id).to eq(1)
    end
  end

  it "can fetch a special order by ID" do
    VCR.use_cassette("account/special_orders/show") do
      special_order = account.special_orders.find(3)
      expect(special_order).to be_a(Lightspeed::SpecialOrder)
    end
  end

end
