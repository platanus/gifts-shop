class NotNullActionType < ActiveRecord::Migration[5.2]
  def change
    change_column_null :product_actions, :action_type, false
  end
end
