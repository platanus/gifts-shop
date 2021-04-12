class RemoveBalanceFromStores < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :stores, :balance}
  end
end
