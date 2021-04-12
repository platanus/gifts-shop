class RemoveHasEnoughBalanceFromStores < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :stores, :has_enough_balance }
  end
end
