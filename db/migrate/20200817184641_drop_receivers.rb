class DropReceivers < ActiveRecord::Migration[5.2]
  def change
    drop_table :receivers, force: :cascade
  end
end
