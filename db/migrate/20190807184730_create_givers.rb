class CreateGivers < ActiveRecord::Migration[5.2]
  def change
    create_table :givers do |t|
      t.string :email
      t.references :region

      t.timestamps
    end
  end
end
