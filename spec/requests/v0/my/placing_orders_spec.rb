require 'rails_helper'

RSpec.describe '/v0/my/placing_orders', type: :request do

  let(:user) { create(:user) }

  before { login_as(user) }

  describe 'GET /v0/my/placing_orders' do
    let!(:placing_orders) { create_list(:order, 3, orderer: user) }

    it 'should be success' do
      get '/v0/my/placing_orders', headers: headers

      expect(response.status).to eq 200
    end
  end

  describe 'GET /v0/my/placing_orders/:id' do
    let!(:placing_order) { create(:order, orderer: user) }

    it 'should be success' do
      get "/v0/my/placing_orders/#{placing_order.id}", headers: headers

      expect(response.status).to eq 200
    end
  end

  describe 'POST /v0/my/placing_orders' do
    let!(:product) { create(:product) }

    let!(:params) do
      {
        product_id:            product.id,
        order_product_version: product.version,
        order_quantity:        3,
        orderer_name:          'Rhonda K. Burkhart',
        orderer_address:       '4014 Riverside Drive Cave Spring, GA 30124',
      }
    end

    context 'Product can be ordered' do
      it 'should be created' do
        post '/v0/my/placing_orders', params:  params.to_json, headers: headers

        expect(response.status).to eq 201
      end
    end

    context 'Product was deleted' do
      before { product.destroy }

      it 'should not be found' do
        post '/v0/my/placing_orders', params:  params.to_json, headers: headers

        expect(response.status).to eq 404
      end
    end
  end

end
