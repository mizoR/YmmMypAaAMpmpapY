require 'rails_helper'

RSpec.describe '/v0/my/products', type: :request do

  let!(:user) { create(:user) }

  before { login_as(user) }

  describe 'POST /v0/my/products' do
    let!(:params) { attributes_for(:product) }

    it 'should be success' do
      post '/v0/my/products', params: params.to_json, headers: headers

      expect(response.status).to eq 201
    end
  end

  describe 'PATCH /v0/my/products/:id' do
    let!(:params) { attributes_for(:product).merge(stock_quantity: 0) }

    let!(:product) { create(:product, owner: user) }

    it 'should be success' do
      patch "/v0/my/products/#{product.id}", params: params.to_json, headers: headers

      expect(response.status).to eq 200
    end
  end

  describe 'DELETE /v0/my/products/:id' do
    let!(:product) { create(:product, owner: user) }

    it 'should be success' do
      delete "/v0/my/products/#{product.id}", headers: headers

      expect(response.status).to eq 204
    end
  end

end
