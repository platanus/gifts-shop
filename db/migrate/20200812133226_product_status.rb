class ProductStatus < ActiveRecord::Migration[5.2]
  def change
    safety_assured { remove_column :products, :display }
  end
end
