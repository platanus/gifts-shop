class CreateDeposit < ActiveRecord::Migration[5.2]
  def change
    create_table :deposits do |t|
      t.references :store, foreign_key: true
      t.bigint :amount, default: 0, null: false
      t.string :amount_currency, default: "CLP", null: false
      t.references :organization, foreign_key: true
      t.timestamps
    end
  end
end
