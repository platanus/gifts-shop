class DropGivers < ActiveRecord::Migration[5.2]
  def change
    drop_table :givers
  end
end
