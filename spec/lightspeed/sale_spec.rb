require 'spec_helper'

describe Lightspeed::Sale do
  setup_client_and_account

  subject do
    Lightspeed::Sale.new(context: account, attributes: { "saleID" => 2 })
  end

  # it "can fetch a sale's Customer" do
  #   subject.customerID = 2
  #   VCR.use_cassette("account/Customer/show") do
  #     customer = subject.customer
  #     expect(customer).to be_a(Lightspeed::Customer)
  #   end
  # end

  # it "can fetch a sale's Employee" do
  #   subject.employeeID = 2
  #   VCR.use_cassette("account/Employee/show") do
  #     employee = subject.employee
  #     expect(employee).to be_a(Lightspeed::Employee)
  #   end
  # end

  # it "can fetch a sale's SaleLines" do
  #   subject.saleID = 2
  #   VCR.use_cassette("account/Sale/show") do
  #     sale_lines = subject.sale_lines
  #     expect(sale_lines).first.to be_a(Lightspeed::SaleLine)
  #   end
  # end

end

