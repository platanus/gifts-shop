class AddHasEnoughBalanceToStores < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :has_enough_balance, :boolean, default: false
  end
end
