class RemoveReminderEmail < ActiveRecord::Migration[5.2]
  def change
    safety_assured { remove_column :reminders, :email }
  end
end
