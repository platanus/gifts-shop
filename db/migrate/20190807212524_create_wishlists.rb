class CreateWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists do |t|
      t.references :product, foreign_key: true
      t.references :receiver, foreign_key: true

      t.timestamps
    end
  end
end
