require_relative 'resource'

module Lightspeed
  class Customer < Lightspeed::Resource
    fields(
      customerID: :id,
      firstName: :string,
      lastName: :string,
      dob: :datetime,
      archived: :boolean,
      title: :string,
      company: :string,
      companyRegistrationNumber: :string,
      vatNumber: :string,
      createTime: :datetime,
      timeStamp: :datetime,
      creditAccountID: :integer,
      customerTypeID: :integer,
      discountID: :integer,
      taxCategoryID: :integer,
      Contact: :hash,
      Note: :hash,
    )
  end
end
