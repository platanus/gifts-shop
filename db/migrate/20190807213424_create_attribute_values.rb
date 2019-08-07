class CreateAttributeValues < ActiveRecord::Migration[5.2]
  def change
    create_table :attribute_values do |t|
      t.string :name
      t.references :attribute, foreign_key: true

      t.timestamps
    end
  end
end
