class DropDepositTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :deposits
  end
end
