class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :owner,          default: 0,  null: false, index: true, foreign_key: { to_table: :users }
      t.string     :name,           default: '', null: false
      t.integer    :price,          default: 0,  null: false
      t.integer    :stock_quantity, default: 0,  null: false
      t.integer    :version,        default: 0,  null: false

      t.timestamps
    end

    execute 'ALTER TABLE products ADD CONSTRAINT check_products_stock_quantity CHECK (stock_quantity >= 0);'
  end
end
