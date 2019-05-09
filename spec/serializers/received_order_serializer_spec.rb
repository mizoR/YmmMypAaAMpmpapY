require 'rails_helper'

RSpec.describe ReceivedOrderSerializer, type: :serializer do
  let(:received_order) { create(:order).becomes(ReceivedOrder) }

  let(:json) { described_class.new(received_order).to_json }

  it 'serializes ReceivedOrder' do
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
