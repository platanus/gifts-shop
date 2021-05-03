class RemoveAverageColorFromProducts < ActiveRecord::Migration[6.1]
  def change
    safety_assured { remove_column :products, :average_color }
  end
end
