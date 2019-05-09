require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:owner) { create(:user) }

  describe '#create' do
    let!(:product) do
      params = attributes_for(:product)

      owner.products.create!(params)
    end

    it 'creates Product' do
      expect(product).to be_persisted
    end
  end

  describe '#update' do
    let!(:product) { create(:product, owner: owner) }

    it 'updates Product' do
      expect(product.stock_quantity).to be > 0

      params = attributes_for(:product)
        .merge(stock_quantity: 0)

      product.update(params)

      expect(product).to be_persisted

      expect(product.stock_quantity).to eq 0
    end
  end
end
