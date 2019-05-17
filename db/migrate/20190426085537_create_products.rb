class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :owner,          null: false, index: true, foreign_key: { to_table: :users }
      t.string     :name,           null: false
      t.integer    :price,          null: false
      t.integer    :stock_quantity, null: false
      t.integer    :version,        null: false, default: 0

      t.timestamps
    end

    execute 'ALTER TABLE products ADD CONSTRAINT check_products_stock_quantity CHECK (stock_quantity >= 0);'
  end
end
