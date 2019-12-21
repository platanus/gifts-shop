class AddFulfillmentColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :fulfilled, :boolean
  end
end
