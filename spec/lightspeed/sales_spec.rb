require 'spec_helper'

describe Lightspeed::Sales do
  setup_client_and_account

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
        sale = account.sales.create(
          taxCategoryID: 0,
          employeeID: 1,
          shopID: 1,
          registerID: 1
        )
        expect(sale).to be_a(Lightspeed::Sale)
        expect(sale.id).not_to be_nil
      end
    end

    it "with an itemCode instead of saleID" do
      # VCR.use_cassette("account/Sales/create_with_itemcode") do
      #   # provide items?
      #   sale = account.sales.create()
      #   expect(sale).to be_a(Lightspeed::Sale)
      #   expect(sale.id).not_to be_nil
      # end
    end
  end

  # TODO updating and archiving

end

