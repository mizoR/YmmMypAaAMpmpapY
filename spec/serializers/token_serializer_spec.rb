require 'rails_helper'

RSpec.describe TokenSerializer, type: :serializer do
  let(:user) { create(:user) }

  let(:token) { user.tokens.issue }

  let(:json) { described_class.new(token).to_json }

  it 'serializes Token' do
    expect(json).to be_json_as(
      id:           Integer,
      access_token: String,
      created_at:   /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\d\d\dZ/,
    )
  end
end
