require 'rails_helper'

RSpec.describe PlacingOrder, type: :model do
  describe '#valid' do
    context 'Order product version is not matched' do
      let!(:product) { create(:product) }

      let!(:orderer) { create(:user) }

      let!(:placing_order) do
        params = attributes_for(:order, order_product_version: product.version)
          .slice(:orderer_name, :orderer_address, :order_quantity, :order_product_version)

        orderer.placing_orders.build(params)
      end


      before do
        product.increment(:version)
      end

      it 'is invalid' do
        expect { orderer.place_order!(placing_order, product) }.to \
          raise_error(ActiveRecord::RecordInvalid)

        expect(placing_order.errors).to have_key(:order_product_version)
      end
    end

    context 'Order quantity is insufficient' do
      let!(:product) { create(:product, stock_quantity: 3) }

      let!(:orderer) { create(:user) }

      let!(:placing_order) do
        params = attributes_for(:order, order_quantity: 4, order_product_version: product.version)
          .slice(:orderer_name, :orderer_address, :order_quantity, :order_product_version)

        orderer.placing_orders.build(params)
      end


      it 'is invalid' do
        expect { orderer.place_order!(placing_order, product) }.to \
          raise_error(ActiveRecord::RecordInvalid)

        expect(placing_order.errors).to have_key(:order_quantity)
      end
    end

    context 'Orderer wallet point is insufficient' do
      let!(:product) { create(:product, price: 500, stock_quantity: 5) }

      let!(:orderer) do
        orderer = create(:user)

        orderer.wallet.update(point: 1400)

        orderer
      end

      let!(:placing_order) do
        params = attributes_for(:order, order_quantity: 3, order_product_version: product.version)
          .slice(:orderer_name, :orderer_address, :order_quantity, :order_product_version)

        orderer.placing_orders.build(params)
      end


      it 'is invalid' do
        expect { orderer.place_order!(placing_order, product) }.to \
          raise_error(ActiveRecord::RecordInvalid)

        expect(placing_order.errors).to have_key(:orderer_wallet_point)
      end
    end
  end
end
