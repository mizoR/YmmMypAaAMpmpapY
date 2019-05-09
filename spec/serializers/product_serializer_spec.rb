require 'rails_helper'

RSpec.describe ProductSerializer, type: :serializer do
  let(:product) { create(:product) }

  let(:json) { described_class.new(product).to_json }

  it 'serializes Product' do
    expect(json).to be_json_as(
      id:             Integer,
      name:           String,
      price:          Integer,
      image_url:      String,
      stock_quantity: Integer,
      version:        Integer,
      created_at:     /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\d\d\dZ/,
    )
  end
end
