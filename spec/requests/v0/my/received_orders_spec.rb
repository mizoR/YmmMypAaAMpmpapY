require 'rails_helper'

RSpec.describe '/v0/my/received_orders', type: :request do

  let(:user) { create(:user) }

  before { login_as(user) }

  describe 'GET /v0/my/received_orders' do
    let!(:received_orders) { create_list(:order, 3, order_receiver: user) }

    it 'should be success' do
      get '/v0/my/received_orders',
        headers: headers

      expect(response.status).to eq 200
    end
  end

  describe 'GET /v0/my/received_orders/:id' do
    let!(:received_order) { create(:order, order_receiver: user) }

    it 'should be success' do
      get "/v0/my/received_orders/#{received_order.id}",
        headers: headers

      expect(response.status).to eq 200
    end
  end

end
