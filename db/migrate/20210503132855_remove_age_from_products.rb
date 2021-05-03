class RemoveAgeFromProducts < ActiveRecord::Migration[6.1]
  def change
    safety_assured { remove_column :products, :age }
  end
end
