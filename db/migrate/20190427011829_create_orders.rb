class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :orderer,         null: false, foreign_key: { to_table: :users }, index: true
      t.references :order_receiver,  null: false, foreign_key: { to_table: :users }, index: true
      t.string     :product_name,    null: false
      t.integer    :product_price,   null: false
      t.string     :orderer_name,    null: false
      t.string     :orderer_address, null: false
      t.integer    :order_quantity,  null: false

      t.timestamps
    end
  end
end
