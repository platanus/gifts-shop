class AddDeletedToProducts < ActiveRecord::Migration[5.2]
  def up
    add_column :products, :deleted, :boolean
    change_column_default :products, :deleted, false
  end

  def down
    remove_column :products, :deleted
  end
end
