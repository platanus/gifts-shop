class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :clicks
      t.string :link
      t.float :clicks_cost
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
