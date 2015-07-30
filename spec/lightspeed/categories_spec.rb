require 'spec_helper'

describe Lightspeed::Categories do
  setup_client_and_account

  it "can fetch categories" do
    VCR.use_cassette("account/categories/index") do
      categories = account.categories.all
      expect(categories).to be_an(Array)
      expect(categories.count).to eq(1)

      category = categories.first
      expect(category).to be_a(Lightspeed::Category)
      expect(category.id).to eq("2")
    end
  end

  context "creating" do
    it "with valid information" do
      VCR.use_cassette("account/categories/create") do
        category = account.categories.create(
          name: "Category One"
        )
        expect(category).to be_a(Lightspeed::Category)
        expect(category.id).not_to be_nil
      end
    end

    it "missing a name" do
      VCR.use_cassette("account/categories/create_invalid") do
        expect do
          account.categories.create(name: "")
        end.to raise_error(Lightspeed::Errors::BadRequest, "name cannot be blank.")
      end
    end
  end

  context "updating" do
    it "with valid information" do
      VCR.use_cassette("account/categories/update") do
        category = account.categories.update(2, name: "Category Two")
        expect(category).to be_a(Lightspeed::Category)
        expect(category.name).to eq("Category Two")
      end
    end

    it "missing a name" do
      VCR.use_cassette("account/categories/update_invalid") do
        expect do
          account.categories.update(2, name: "")
        end.to raise_error(Lightspeed::Errors::BadRequest, "name cannot be blank.")
      end
    end
  end

  it "can destroy an item" do
    VCR.use_cassette("account/categories/destroy") do
      account.categories.destroy(2)
      expect do
        account.categories.find(2)
      end.to raise_error(Lightspeed::Errors::NotFound, %(Could not find a Category by {"categoryID"=>2}))
    end
  end
end
