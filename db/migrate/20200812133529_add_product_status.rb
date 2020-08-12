class AddProductStatus < ActiveRecord::Migration[5.2]
  def up
    add_column :products, :status, :string
  end

  def down
    remove_column :products, :status
  end
end
