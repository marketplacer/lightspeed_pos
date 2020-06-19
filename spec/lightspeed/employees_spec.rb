# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Employees do
  setup_client_and_account

  it "can fetch employees" do
    VCR.use_cassette("account/employees/index") do
      employees = account.employees.all
      expect(employees).to be_an(Array)
      expect(employees.count).to be >= 1

      employee = employees.first

      expect(employee).to be_a(Lightspeed::Employee)
    end
  end

  it "can fetch an employee by ID" do
    VCR.use_cassette("account/employees/show") do
      employee = account.employees.find(1)
      expect(employee).to be_a(Lightspeed::Employee)
    end
  end
end
