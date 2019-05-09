require 'rails_helper'

RSpec.describe Token, type: :model do
  describe '.#issue' do
    let(:user) { create(:user) }

    it 'issues Token' do
      token = user.tokens.issue

      expect(token).to be_persisted

      expect(token.access_token.size).to eq(64)
    end
  end

  describe '.#unauthorized' do
    let(:token) { Token.unauthorized }

    it 'issues Token' do
      expect(token.errors).to have_key(:base)
    end
  end
end
