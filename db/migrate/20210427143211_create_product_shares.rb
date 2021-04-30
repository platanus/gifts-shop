class CreateProductShares < ActiveRecord::Migration[6.1]
  def change
    create_table :product_shares do |t|
      t.bigint :platform
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
