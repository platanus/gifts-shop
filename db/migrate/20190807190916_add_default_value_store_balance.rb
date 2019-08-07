class AddDefaultValueStoreBalance < ActiveRecord::Migration[5.2]
  def up
    change_column_default :stores, :balance, 0
  end
end
