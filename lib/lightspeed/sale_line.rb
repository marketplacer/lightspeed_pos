require_relative 'resource'

module Lightspeed
  class SaleLine < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      saleLineID: :id,
      createTime: :timeStamp,
      timeStamp: :timeStamp,
      unitQuantity: :integer,
      unitPrice: :decimal,
      normalUnitPrice: :decimal,
      discountAmount: :decimal,
      discountPercent: :decimal,
      avgCost: :decimal,
      fifoCost: :decimal,
      tax: :boolean,
      tax1Rate: :decimal,
      tax2Rate: :decimal,
      isLayaway: :boolean,
      isWorkorder: :boolean,
      isSpecialOrder: :boolean,
      displayableSubtotal: :decimal,
      displayableUnitPrice: :decimal,
      calcLineDiscount: :decimal,
      calcTransactionDiscount: :decimal,
      calcTotal: :decimal,
      calcSubtotal: :decimal,
      calcTax1: :decimal,
      calcTax2: :decimal,
      taxClassID: :id,
      customerID: :id,
      discountID: :id,
      employeeID: :id,
      itemID: :id,
      noteID: :id,
      parentSaleLineID: :id,
      shopID: :id,
      saleID: :id,
      TaxClass: :hash,
      Discount: :hash,
      # Item: :hash,
      Note: :hash
    )

    relationships :Item

  end
end


