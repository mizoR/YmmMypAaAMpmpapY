class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :orderer,         null: false, default: 0, foreign_key: { to_table: :users }, index: true
      t.references :order_receiver,  null: false, default: 0, foreign_key: { to_table: :users }, index: true
      t.string     :product_name,    null: false, default: ''
      t.integer    :product_price,   null: false, default: 0
      t.string     :orderer_name,    null: false, default: ''
      t.string     :orderer_address, null: false, default: ''
      t.integer    :order_quantity,  null: false, default: 0

      t.timestamps
    end
  end
end
