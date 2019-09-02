class AddShowAttrToProduct < ActiveRecord::Migration[5.2]
  def up
    add_column :products, :display, :boolean
    change_column_default :products, :display, false
  end

  def down
    remove_column :products, :display
  end
end
