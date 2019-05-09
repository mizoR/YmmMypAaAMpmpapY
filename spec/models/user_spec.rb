require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#create' do
    let(:user) { build(:user) }

    it 'creates User' do
      expect(user).to be_valid

      expect(user.save).to be(true)

      expect(user.wallet).to be_persisted

      expect(user.wallet.point).to eq 10000
    end
  end

  describe '#place_order!' do
    let!(:user) { create(:user) }

    let!(:product) { create(:product) }

    let!(:placing_order) do
      params = attributes_for(:order)
        .slice(:orderer_name, :orderer_address, :order_quantity)
        .merge(order_product_version: product.version)

      user.placing_orders.build(params)
    end

    it 'Order should be confirmed' do
      user.place_order!(placing_order, product)

      expect(placing_order).to be_persisted
    end

    it 'Wallet point should be drawed' do
      expect { user.place_order!(placing_order, product) }.to \
        change { user.wallet.reload.point }.by(- product.price)

      expect(placing_order).to be_persisted
    end

    it 'Stock quantity should be decreased' do
      expect { user.place_order!(placing_order, product) }.to \
        change { product.reload.stock_quantity }.by(- placing_order.order_quantity)

      expect(placing_order).to be_persisted
    end
  end

end
