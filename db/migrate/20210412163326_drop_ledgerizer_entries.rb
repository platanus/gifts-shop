class DropLedgerizerEntries < ActiveRecord::Migration[6.0]
  def change
    drop_table :ledgerizer_entries
  end
end
