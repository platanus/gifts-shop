class RemoveReceiverFromProductActions < ActiveRecord::Migration[5.2]
  def change
    safety_assured { remove_reference :product_actions, :receiver, foreign_key: true }
  end
end
