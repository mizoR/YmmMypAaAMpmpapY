class PlacingOrder < Order
  # NOTE: Needs following accessors to create an order
  attr_writer :orderer_wallet_point, :product_stock_quantity, :product_version, :order_product_version

  validates :orderer_name,
    presence: true,
    length: { in: 1..255 },
    on: :create

  validates :orderer_address,
    presence: true,
    length: { in: 1..255 },
    on: :create

  validate :orderer_wallet_point_is_insufficient,
    on: :create

  validate :product_stock_quantity_is_insufficient,
    on: :create

  validate :product_version_is_not_matched,
    on: :create

  def orderer_wallet_point
    Integer(@orderer_wallet_point)
  end

  def order_product_version
    Integer(@order_product_version)
  end

  def product_stock_quantity
    Integer(@product_stock_quantity)
  end

  def product_version
    Integer(@product_version)
  end

  private

  def orderer_wallet_point_is_insufficient
    if order_amount > orderer_wallet_point
      errors.add(:orderer_wallet_point, 'is insufficient')
    end
  end

  def product_stock_quantity_is_insufficient
    if order_quantity > product_stock_quantity
      errors.add(:order_quantity, 'is over the stock quantity')
    end
  end

  def product_version_is_not_matched
    unless order_product_version == product_version
      errors.add(:order_product_version, 'is not matched')
    end
  end
end
