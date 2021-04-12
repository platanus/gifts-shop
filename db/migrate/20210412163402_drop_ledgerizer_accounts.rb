class DropLedgerizerAccounts < ActiveRecord::Migration[6.0]
  def change
    drop_table :ledgerizer_accounts
  end
end
