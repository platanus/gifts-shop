class NotNullDepositTime < ActiveRecord::Migration[5.2]
  def change
    change_column_null :deposits, :deposit_time, false
  end
end
