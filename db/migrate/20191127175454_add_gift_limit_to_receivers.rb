class AddGiftLimitToReceivers < ActiveRecord::Migration[5.2]
  def change
    add_column :receivers, :gift_limit, :integer
  end
end
