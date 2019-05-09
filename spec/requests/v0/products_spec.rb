require 'rails_helper'

RSpec.describe 'Products', type: :request do

  describe 'GET /v0/products' do
    before(:each) do
      create_list(:product, 3)
    end

    it 'should be success' do
      get '/v0/products',
        headers: headers

      expect(response.status).to eq 200
    end
  end

end
