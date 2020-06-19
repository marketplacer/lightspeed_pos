# frozen_string_literal: true

require_relative 'resource'

require_relative 'sale_lines'

module Lightspeed
  class Sale < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      saleID: :id,
      timeStamp: :datetime,
      discountPercent: :decimal,
      completed: :boolean,
      archived: :boolean,
      voided: :boolean,
      enablePromotions: :boolean,
      referenceNumber: :string,
      referenceNumberSource: :string,
      tax1Rate: :decimal,
      tax2Rate: :decimal,
      change: :decimal,
      calcDiscount: :decimal,
      calcTotal: :decimal,
      calcSubtotal: :decimal,
      calcTaxable: :decimal,
      calcNonTaxable: :decimal,
      calcAvgCost: :decimal,
      calcFIFOCost: :decimal,
      calcTax1: :decimal,
      calcTax2: :decimal,
      calcPayments: :decimal,
      total: :decimal,
      totalDue: :decimal,
      displayableTotal: :decimal,
      balance: :decimal,
      customerID: :id,
      discountID: :id,
      employeeID: :id,
      quoteID: :id,
      registerID: :id,
      shipToID: :id,
      shopID: :id,
      taxCategoryID: :id,
      Customer: :hash,
      Discount: :hash,
      Quote: :hash,
      ShipTo: :hash,
      TaxCategory: :hash,
      # SaleLines: :integer,
      SalePayments: :hash
    )

    relationships :SaleLines, :Employee

  end
end

