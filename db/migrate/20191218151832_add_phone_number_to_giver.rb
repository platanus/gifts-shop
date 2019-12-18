class AddPhoneNumberToGiver < ActiveRecord::Migration[5.2]
  def change
    add_column :givers, :phone_number, :string
  end
end
