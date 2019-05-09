class ReceivedOrderSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :product_price, :orderer_name, :orderer_address, :order_quantity, :created_at
end
