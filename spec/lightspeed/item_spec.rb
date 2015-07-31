require 'spec_helper'

describe Lightspeed::Item do
  setup_client_and_account

  subject do
    Lightspeed::Item.new(account, id: 2)
  end

  it "can fetch an item's ItemMatrix" do
    subject.itemMatrixID = 2
    VCR.use_cassette("account/ItemMatrix/show") do
      matrix = subject.item_matrix
      expect(matrix).to be_a(Lightspeed::ItemMatrix)
    end
  end

  it "can get the attributes of an item" do
    expect(subject.attributes).to eq({ id: 2 })
  end

  it "can show a JSON representation of an item" do
    expect(subject.to_json).to eq({ id: 2}.to_json)
  end
end
