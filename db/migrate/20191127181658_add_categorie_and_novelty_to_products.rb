class AddCategorieAndNoveltyToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :gender, :integer
    change_column_default :products, :gender, 0
    add_column :products, :age, :integer
    change_column_default :products, :age, 0
    add_column :products, :novelty, :integer
  end
end
