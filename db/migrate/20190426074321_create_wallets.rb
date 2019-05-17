class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.references :user,  null: false, index: { unique: true }, foreign_key: true
      t.integer    :point, null: false

      t.timestamps
    end

    execute 'ALTER TABLE wallets ADD CONSTRAINT check_wallets_point CHECK (point >= 0);'
  end
end
