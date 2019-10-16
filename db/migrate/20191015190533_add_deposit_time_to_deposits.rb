class AddDepositTimeToDeposits < ActiveRecord::Migration[5.2]
  def change
    add_column :deposits, :deposit_time, :date
  end
end
