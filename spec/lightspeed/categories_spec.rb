require 'spec_helper'

describe Lightspeed::Categories, configure: true do
  let(:account) do
    Lightspeed::Account.new.tap do |account|
      account.id = 113665
    end
  end

  it "can fetch categories" do
    VCR.use_cassette("account/categories/index") do
      categories = account.categories.all
      expect(categories).to be_an(Array)
      expect(categories.count).to eq(1)

      category = categories.first
      expect(category).to be_a(Lightspeed::Category)
      expect(category.id).to eq("1")
    end
  end

  context "creating" do
    it "with valid information" do
      VCR.use_cassette("account/categories/create") do
        category = account.categories.create({
          name: "Category One"
        })
        expect(category).to be_a(Lightspeed::Category)
        expect(category.id).not_to be_nil
      end
    end

    it "missing a name" do
      VCR.use_cassette("account/categories/create_invalid") do
        expect do
          item = account.categories.create({
            name: ""
          })
        end.to raise_error(Lightspeed::Errors::BadRequest, "name cannot be blank.")
      end
    end
  end
end
