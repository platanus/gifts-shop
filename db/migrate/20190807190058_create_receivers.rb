class CreateReceivers < ActiveRecord::Migration[5.2]
  def change
    create_table :receivers do |t|
      t.string :name
      t.string :email
      t.references :giver, foreign_key: true
      t.references :relation, foreign_key: true

      t.timestamps
    end
  end
end
