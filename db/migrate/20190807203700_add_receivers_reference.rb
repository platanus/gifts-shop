class AddReceiversReference < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def change
    add_reference :reminders, :receivers, index: false
    add_index :reminders, :receivers_id, algorithm: :concurrently
  end
end
