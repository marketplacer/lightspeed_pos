# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Sales do
  setup_client_and_account

  let(:empty_sale_data) { { taxCategoryID: 0, employeeID: 1, shopID: 1, registerID: 1 } }

  it "can fetch sales" do
    VCR.use_cassette("account/Sales/index") do
      sales = account.sales.all
      expect(sales).to be_an(Array)
      expect(sales.count).to be > 1
      sale = sales.first
      expect(sale).to be_a(Lightspeed::Sale)
      expect(sale.id).to eq(1)
    end
  end

  it "can fetch an sale by ID" do
    VCR.use_cassette("account/Sales/show") do
      sale = account.sales.find(4)
      expect(sale).to be_a(Lightspeed::Sale)
    end
  end

  context "creating" do
    it "with minimum required information" do
      VCR.use_cassette("account/Sales/create") do
        sale = account.sales.create empty_sale_data
        expect(sale).to be_a(Lightspeed::Sale)
        expect(sale.id).not_to be_nil
      end
    end

    it "with an item" do
      VCR.use_cassette("account/Sales/create") do
        sale = account.sales.create empty_sale_data.merge(
          SaleLines: [
            { SaleLine: {
              itemID: 1,
              unitQuantity: 2,
              unitPrice: "1.23",
              tax: true
            }}
          ]
        )
        expect(sale).to be_a(Lightspeed::Sale)
        expect(sale.id).not_to be_nil
        expect(sale.total).to eq(2.46)
      end
    end

    it "with an itemCode instead of itemID" do
      VCR.use_cassette("account/Sales/create_with_itemcode") do
        sale = account.sales.create empty_sale_data.merge(
          SaleLines: [
            { SaleLine: {
              itemCode: "210000000177",
              unitQuantity: 3,
              unitPrice: "0.11",
              tax: true
            }}
          ]
        )
        expect(sale).to be_a(Lightspeed::Sale)
        expect(sale.id).not_to be_nil
        expect(sale.total).to eq(0.33)
      end
    end
  end

  context "updating" do
    it "adding an item" do
      VCR.use_cassette("account/Sales/update") do
        sale = account.sales.update 1, {
          SaleLines: [
            { SaleLine: {
              itemID: 1,
              unitQuantity: 1,
              unitPrice: "0.01",
              tax: false
            }}
          ]
        }
        expect(sale).to be_a(Lightspeed::Sale)
        expect(sale.id).not_to be_nil
        expect(sale.total).to eq(5.18)
      end
    end
  end

  # TODO archiving

end

