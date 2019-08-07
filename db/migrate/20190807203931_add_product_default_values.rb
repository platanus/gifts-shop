class AddProductDefaultValues < ActiveRecord::Migration[5.2]
  def change
    change_column_default :products, :clicks, 0
  end
end
