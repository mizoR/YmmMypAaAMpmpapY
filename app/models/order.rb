class Order < ApplicationRecord
  belongs_to :orderer, class_name: 'User'

  belongs_to :order_receiver, class_name: 'User'

  def order_amount
    product_price * order_quantity
  end
end
