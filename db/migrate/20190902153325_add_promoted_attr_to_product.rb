class AddPromotedAttrToProduct < ActiveRecord::Migration[5.2]
  def up
    add_column :products, :promoted, :boolean
    change_column_default :products, :promoted, false
  end

  def down
    remove_column :products, :promoted
  end
end
