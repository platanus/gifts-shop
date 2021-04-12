class RemovePromotedFromProducts < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :products, :promoted }
  end
end
