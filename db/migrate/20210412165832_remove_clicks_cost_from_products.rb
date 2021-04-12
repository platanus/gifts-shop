class RemoveClicksCostFromProducts < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :products, :clicks_cost }
  end
end
