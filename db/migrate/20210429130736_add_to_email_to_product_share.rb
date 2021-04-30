class AddToEmailToProductShare < ActiveRecord::Migration[6.1]
  def change
    add_column :product_shares, :to_email, :string
  end
end
