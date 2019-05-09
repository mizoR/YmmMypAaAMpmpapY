require 'rails_helper'

RSpec.describe PlacingOrderSerializer, type: :serializer do
  let(:placing_order) { create(:order).becomes(PlacingOrder) }

  let(:json) { described_class.new(placing_order).to_json }

  it 'serializes PlacingOrder' do
    expect(json).to be_json_as(
      id:              Integer,
      product_name:    String,
      product_price:   Integer,
      orderer_name:    String,
      orderer_address: String,
      order_quantity:  Integer,
      created_at:      /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\d\d\dZ/,
    )
  end
end
