class DropLedgerizerLines < ActiveRecord::Migration[6.0]
  def change
    drop_table :ledgerizer_lines
  end
end
