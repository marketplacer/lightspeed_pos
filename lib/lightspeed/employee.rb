# frozen_string_literal: true

require_relative 'resource'

module Lightspeed
  class Employee < Lightspeed::Resource
    fields(
      employeeID: :id,
      firstName: :string,
      lastName: :string,
      accessPin: :string,
      lockOut: :boolean,
      archived: :boolean,
      contactID: :integer,
      clockInEmployeeHoursID: :integer,
      employeeRoleID: :integer,
      limitToShopID: :integer,
      lastShopID: :integer,
      lastSaleID: :integer,
      lastRegisterID: :integer,
      timeStamp: :datetime,
      Contact: :hash,
      EmployeeRole: :hash,
      EmployeeRights: :hash
    )
  end
end
