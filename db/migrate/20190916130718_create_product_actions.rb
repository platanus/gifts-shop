class CreateProductActions < ActiveRecord::Migration[5.2]
  def change
    create_table :product_actions do |t|
      t.references :product, foreign_key: true
      t.references :receiver, foreign_key: true
      t.integer :action_type

      t.timestamps
    end
  end
end
