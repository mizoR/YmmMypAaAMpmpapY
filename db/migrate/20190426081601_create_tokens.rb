class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.references :user,         null: false, foreign_key: true
      t.string     :access_token, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
