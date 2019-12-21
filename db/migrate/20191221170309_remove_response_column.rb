class RemoveResponseColumn < ActiveRecord::Migration[5.2]
  def change
    safety_assured { remove_column :feedbacks, :response }
  end
end
