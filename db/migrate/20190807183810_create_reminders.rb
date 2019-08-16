class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.string :email
      t.string :name
      t.datetime :date
      t.references :occation

      t.timestamps
    end
  end
end
