# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Sale do
  setup_client_and_account

  subject do
    Lightspeed::Sale.new(context: account, attributes: { "saleID" => 2 })
  end

  it "can fetch a sale's Employee" do
    subject.employeeID = 1
    VCR.use_cassette("account/Sales/employee") do
      employee = subject.employee
      expect(employee).to be_a(Lightspeed::Employee)
    end
  end

  it "can fetch a sale's SaleLines" do
    subject.saleID = 2
    VCR.use_cassette("account/Sales/sale_lines") do
      sale_lines = subject.sale_lines
      expect(sale_lines.first).to be_a(Lightspeed::SaleLine)
    end
  end

end

