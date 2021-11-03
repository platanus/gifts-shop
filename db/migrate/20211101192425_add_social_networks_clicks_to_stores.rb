class AddSocialNetworksClicksToStores < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :facebook_clicks, :integer, default: 0
    add_column :stores, :instagram_clicks, :integer, default: 0
    add_column :stores, :twitter_clicks, :integer, default: 0
  end
end
