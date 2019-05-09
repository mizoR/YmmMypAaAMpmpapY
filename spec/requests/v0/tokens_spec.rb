require 'rails_helper'

RSpec.describe 'Tokens', type: :request do

  describe 'POST /v0/tokens' do
    context 'Valid credentials' do
      let(:user) { create(:user) }

      before do
        @params = { email: user.email, password: user.password }
      end

      it 'should be created' do
        post '/v0/tokens',
          params:  @params.to_json,
          headers: headers

        expect(response.status).to eq 201
      end
    end

    context 'Invalid credentials' do
      let(:user) { create(:user) }

      before do
        @params = { email: user.email, password: user.password.reverse }
      end

      it 'should be created' do
        post '/v0/tokens',
          params:  @params.to_json,
          headers: headers

        expect(response.status).to eq 401
      end
    end
  end

end
