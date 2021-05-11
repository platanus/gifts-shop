class AddPriceIntervalToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :price_interval, :integer, default: 0
  end
end
