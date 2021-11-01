class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  belongs_to :region

  validates :name, presence: true, length: { minimum: 5, maximum: 20 }

  def self.randomized(seed = 0.0)
    connection.execute(Arel.sql("SELECT SETSEED(#{seed})"))
    order(Arel.sql('RANDOM()'))
  end

  def total_products_clicks
    products.sum(:clicks)
  end

  def total_products_displays
    products.sum(&:times_displayed)
  end

  def add_social_network_click(social_network)
    case social_network
    when 'facebook'
      facebook_clicks = self.facebook_clicks + 1
      update(facebook_clicks: facebook_clicks)
    when 'instagram'
      instagram_clicks = self.instagram_clicks + 1
      update(instagram_clicks: instagram_clicks)
    when 'twitter'
      twitter_clicks = self.twitter_clicks + 1
      update(twitter_clicks: twitter_clicks)
    end
  end
end

# == Schema Information
#
# Table name: stores
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  name                   :string
#  region_id              :bigint(8)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  website                :string
#  facebook               :string
#  instagram              :string
#  twitter                :string
#  facebook_clicks        :integer          default(0)
#  instagram_clicks       :integer          default(0)
#  twitter_clicks         :integer          default(0)
#
# Indexes
#
#  index_stores_on_email                 (email) UNIQUE
#  index_stores_on_region_id             (region_id)
#  index_stores_on_reset_password_token  (reset_password_token) UNIQUE
#
