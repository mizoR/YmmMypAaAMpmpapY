class User < ApplicationRecord
  has_secure_password

  has_one :wallet, dependent: :destroy

  has_many :tokens, dependent: :destroy

  has_many :products, foreign_key: :owner_id, dependent: :destroy

  has_many :placing_orders, foreign_key: :orderer_id, class_name: 'PlacingOrder', dependent: :destroy

  has_many :received_orders, foreign_key: :order_receiver_id, class_name: 'ReceivedOrder', dependent: :destroy

  after_create :create_wallet!

  validates :email,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  def place_order!(placing_order, product)
    wallet.with_lock do
      placing_order.assign_attributes(
        order_receiver_id:      product.owner_id,
        product_name:           product.name,
        product_price:          product.price,
        product_stock_quantity: product.stock_quantity,
        product_version:        product.version,
        orderer_wallet_point:   wallet.point,
      )

      placing_order.save!

      # NOTE: 同時アクセスにより在庫数を超えて発注が行われるのを防ぐ。
      #       クエリは `stock_quantity = stock_quantity - ?` としてクエリさせ、
      #       MySQLのCHECK制約 `stock_quantity >= 0` により在庫数を超えた注文が成功しないように保護する。
      product.decrement!(:stock_quantity, placing_order.order_quantity)

      # NOTE: 同時アクセスにより過剰にポイントが引き落とされるのを防ぐ。
      #       クエリは `point = point - ?` としてクエリさせ、
      #       MySQLのCHECK制約 `point >= 0` によりポイント数を超えた注文が成功しないように保護する。
      wallet.decrement!(:point, placing_order.order_amount)

      placing_order
    end
  end
end
