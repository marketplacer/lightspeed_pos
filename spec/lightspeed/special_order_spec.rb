# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::SpecialOrder do
  setup_client_and_account

  subject do
    Lightspeed::SpecialOrder.new(context: account, attributes: { "saleLineID" => 2, "shopID" => 1 })
  end

  it "can fetch a special order's SaleLine" do
    VCR.use_cassette("account/Sales/sale_line") do
      expect(subject.sale_line).to be_a(Lightspeed::SaleLine)
    end
  end

  it "can fetch a special order's Shop" do
    VCR.use_cassette("account/shops/show") do
      expect(subject.shop).to be_a(Lightspeed::Shop)
    end
  end

end

