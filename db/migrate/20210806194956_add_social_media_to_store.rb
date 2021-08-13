class AddSocialMediaToStore < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :website, :string
    add_column :stores, :facebook, :string
    add_column :stores, :instagram, :string
    add_column :stores, :twitter, :string
  end
end
