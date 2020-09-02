class AddCategoryToProducts < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_reference :products, :category, index: false
    add_index :products, :category_id, algorithm: :concurrently
  end
end
