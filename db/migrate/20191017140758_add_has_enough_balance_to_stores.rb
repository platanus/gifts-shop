class AddHasEnoughBalanceToStores < ActiveRecord::Migration[5.2]
  def up
    add_column :stores, :has_enough_balance, :boolean
    change_column_default :stores, :has_enough_balance, false
  end

  def down
    remove_column :stores, :has_enough_balance
  end
end
