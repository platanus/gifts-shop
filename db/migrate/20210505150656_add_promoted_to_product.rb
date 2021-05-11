class AddPromotedToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :promoted, :boolean, default: false
  end
end
