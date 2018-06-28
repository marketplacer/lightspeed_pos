require_relative 'resource'

module Lightspeed
  class Customer < Lightspeed::Resource
    fields(
      customerID: :integer,
      firstName: :string,
      lastName: :string,
      dob: :datetime,
      title: :string,
      company: :string,
      companyRegistrationNumber: :string,
      vatNumber: :string,
      customerTypeID: :integer,
      discountID: :integer,
      taxCategoryID: :integer,
      Contact: :hash
    )
  end
end