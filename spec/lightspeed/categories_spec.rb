# frozen_string_literal: true

require 'spec_helper'

CATEGORY_ID = 2

describe Lightspeed::Categories do
  setup_client_and_account

  it 'can fetch categories' do
    VCR.use_cassette('account/categories/index') do
      categories = account.categories.all
      expect(categories).to be_an(Array)
      expect(categories.count).to be > 1

      category = categories.first
      expect(category).to be_a(Lightspeed::Category)
      expect(category.id).to_not be_nil
    end
  end

  context 'creating' do
    it 'with valid information' do
      VCR.use_cassette('account/categories/create') do
        category = account.categories.create(
          name: 'Category One'
        )
        expect(category).to be_a(Lightspeed::Category)
        expect(category.id).to_not be_nil
      end
    end

    it 'missing a name' do
      VCR.use_cassette('account/categories/create_invalid') do
        expect { account.categories.create(name: '') }.to(
          raise_error(Lightspeed::Error::BadRequest, 'name cannot be blank.')
        )
      end
    end
  end

  context "updating" do
    it 'with valid information' do
      VCR.use_cassette('account/categories/update') do
        id = account.categories.create(name: 'Category to update').id
        category = account.categories.update(id, name: 'Category Two')
        expect(category).to be_a(Lightspeed::Category)
        expect(category.name).to eq('Category Two')
      end
    end

    it 'missing a name' do
      VCR.use_cassette('account/categories/update_invalid') do
        id = account.categories.create(name: 'Category to update').id
        expect { account.categories.update(id, name: '') }.to(
          raise_error(Lightspeed::Error::BadRequest, 'name cannot be blank.')
        )
      end
    end
  end

  it 'can destroy an item' do
    VCR.use_cassette('account/categories/destroy') do
      id = account.categories.create(name: 'Category to delete').id
      destroyed = account.categories.destroy(id)
      expect(destroyed).to be_a Lightspeed::Category
      expect { account.categories.find(id) }.to(
        raise_error(Lightspeed::Error::NotFound, "Could not find a Category with categoryID=#{id}")
      )
    end
  end
end
