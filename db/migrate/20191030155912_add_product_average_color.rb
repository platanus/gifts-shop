class AddProductAverageColor < ActiveRecord::Migration[5.2]
  def up
    add_column :products, :average_color, :text
    change_column_default :products, :average_color, "#000000"
  end

  def down
    remove_column :products, :average_color
  end
end
