require 'spec_helper'

describe Lightspeed::Item do
  setup_client_and_account

  subject do
    Lightspeed::Item.new(account, id: 2)
  end

  it "can fetch an item's ItemMatrix" do
    subject.itemMatrixID = 2
    VCR.use_cassette("account/ItemMatrix/show") do
      matrix = subject.ItemMatrix
      expect(matrix).to be_a(Lightspeed::ItemMatrix)
    end
  end
end
