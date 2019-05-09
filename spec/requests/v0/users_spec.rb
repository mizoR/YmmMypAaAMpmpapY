require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'POST /v0/users' do
    it 'should be created' do
      post '/v0/users',
        params: attributes_for(:user).to_json,
        headers: headers

      expect(response.status).to eq 201
    end
  end

end
