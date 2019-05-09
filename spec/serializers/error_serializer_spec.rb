require 'rails_helper'

RSpec.describe ErrorSerializer, type: :serializer do

  let(:json) { described_class.new(object).to_json }

  context 'Product not found' do
    let(:object) { Product.not_found }

    it 'serializes Product not found error' do
      expect(json).to be_json_as(
        errors: [
          {
            resource: 'Product',
            field:    'base',
            message:  'Not found',
          }
        ]
      )
    end
  end

  context 'PlacingOrder not found' do
    let(:object) { PlacingOrder.not_found }

    it 'serializes PlacingOrder not found error' do
      expect(json).to be_json_as(
        errors: [
          {
            resource: 'PlacingOrder',
            field:    'base',
            message:  'Not found',
          }
        ]
      )
    end
  end

  context 'Token unauthorized' do
    let(:object) { Token.unauthorized }

    it 'serializes PlacingOrder not found error' do
      expect(json).to be_json_as(
        errors: [
          {
            resource: 'Token',
            field:    'base',
            message:  'Unauthorized',
          }
        ]
      )
    end
  end

end
