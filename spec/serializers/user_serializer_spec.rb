require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { create(:user) }

  let(:json) { described_class.new(user).to_json }

  it 'serializes User' do
    expect(json).to be_json_as(
      id:           Integer,
      created_at:   /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\d\d\dZ/,
    )
  end
end
