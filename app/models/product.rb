class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :image
  has_one_attached :recommender_image
  belongs_to :store
  has_many :product_actions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }
  validates :price, presence: true
  validates :link, presence: true
  validates :novelty,
    numericality: { greater_than: 0, less_than_or_equal_to: 5 },
    allow_blank: true

  enum gender: { either: 0, male: 1, female: 2 }
  enum age: { any: 0, kid: 1, teen: 2, adult: 3 }

  def set_average_color
    image = MiniMagick::Image.open(url_for(self.image))
    red, blue, green = image.resize("1x1").get_pixels[0][0]
    update(average_color: hex_value(red, blue, green))
  end

  def attach_image_from_url(url)
    require 'open-uri'
    downloaded_image = open(url)
    filename = File.basename(URI.parse(url).path)
    image.attach(io: downloaded_image, filename: "#{filename}_#{id}.jpg")
    update_recommender_image
    set_average_color
  end

  def update_image(image_param)
    image.attach(image_param)
    update_recommender_image
    set_average_color
  end

  def update_recommender_image
    require 'open-uri'
    url = url_for(image.variant(resize: "224x224"))
    downloaded_image = open(url)
    filename = File.basename(URI.parse(url).path)
    recommender_image.attach(io: downloaded_image, filename: "#{filename}_#{id}.jpg")
  end

  def validate_image
    update(display: false) if !image.attached?
  end

  private

  def hex_value(red, green, blue)
    "##{to_hex red}#{to_hex green}#{to_hex blue}"
  end

  def to_hex(value)
    value.to_s(16).rjust(2, '0').upcase
  end
end

# == Schema Information
#
# Table name: products
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  price         :float
#  clicks        :integer          default(0)
#  link          :string
#  clicks_cost   :float
#  store_id      :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  display       :boolean          default(FALSE)
#  promoted      :boolean          default(FALSE)
#  deleted       :boolean          default(FALSE)
#  average_color :text             default("#000000")
#  gender        :integer          default("either")
#  age           :integer          default("any")
#  novelty       :integer
#
# Indexes
#
#  index_products_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
